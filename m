Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38E779B8FF
	for <lists+linux-rdma@lfdr.de>; Sat, 24 Aug 2019 01:41:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725782AbfHWXlk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 23 Aug 2019 19:41:40 -0400
Received: from mail-pl1-f180.google.com ([209.85.214.180]:40465 "EHLO
        mail-pl1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725283AbfHWXlk (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 23 Aug 2019 19:41:40 -0400
Received: by mail-pl1-f180.google.com with SMTP id h3so6432847pls.7
        for <linux-rdma@vger.kernel.org>; Fri, 23 Aug 2019 16:41:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KFA3JD8/xRJ4eOK2EI8Rzz9iVovpG18oSiXIKRj77Ss=;
        b=kWzcpXzfZgcvFUUUmgQvb7ABHHnXvhWsxI4YBWzUqlL8jk2rTZrOgoUpr3aVr8h7ra
         3OCbGAhIQKMTWbjF5QG3fG+2Yqh1a7BXqqA+zl8AAWZ2WKirW9z4ZVyf9BoP1YuYJuiv
         kJENTYRneeKAs7XTjQAvIjDFUhjXUV282n+0i9OxNLJyxKqpjs2uFLL0D6OG7GQxQ/p/
         YV4f6uir1ZMQRIr04jysEZ+03OTCI7s2q+sfTtYbIgAN8zqLyGwTAsFApGLKJbtt35to
         XFYraJQxxR+qp+EvAcQUYKtSc43HOiDdZut9/1DYKJ6wHD3W+nDKlmh6C/hSpF3V79xh
         yV8Q==
X-Gm-Message-State: APjAAAWKu1CgK5gesJCBzOdHUVHqP0sosG5pfLJ6ha9CJL8A43bdbBFy
        uHesaLC20M1ODTI9xK/MeDWRRVYK
X-Google-Smtp-Source: APXvYqy7+WmqC246N7GQcy1n8kIKk03fJ42OhdaD88/YuSgMlj37OskAhJMyfje/88Y3ZWTqefAUAA==
X-Received: by 2002:a17:902:223:: with SMTP id 32mr7684382plc.220.1566603698866;
        Fri, 23 Aug 2019 16:41:38 -0700 (PDT)
Received: from asus.site ([2601:647:4000:1349:56c2:95e9:3c7:9c11])
        by smtp.gmail.com with ESMTPSA id 16sm6508609pfc.66.2019.08.23.16.41.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Aug 2019 16:41:38 -0700 (PDT)
Subject: Re: siw trigger BUG: sleeping function called from invalid context at
 mm/slab.h:50
To:     Bernard Metzler <bmt@zurich.ibm.com>, linux-rdma@vger.kernel.org
References: <6ed77231-800b-f629-5d15-14409f0777c7@acm.org>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <03dfc9ef-c854-4821-7eaa-9f862bcc6d70@acm.org>
Date:   Fri, 23 Aug 2019 16:41:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <6ed77231-800b-f629-5d15-14409f0777c7@acm.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 8/23/19 4:02 PM, Bart Van Assche wrote:
> If I try to associate the ib_srpt driver with the siw driver the
> complaint shown below appears on the console.
According to gdb:

(gdb) list *(siw_create_listen+0x2f5)
0x6195 is in siw_create_listen (drivers/infiniband/sw/siw
/siw_cm.c:2011).
2006                            bind_addr.sin6_port =
                                         s_laddr->sin6_port;
2007                            bind_addr.sin6_flowinfo = 0;
2008                            bind_addr.sin6_addr = ifp->addr;
2009                            bind_addr.sin6_scope_id = dev->ifindex;
2010
2011                            rv = siw_listen_address(id, backlog,
2012                                      (struct sockaddr *)&bind_addr,
2013                                            AF_INET6);
2014                            if (!rv)
2015                                      listeners++;

This is the code that causes trouble:

	read_lock_bh(&in6_dev->lock);
	list_for_each_entry(ifp, &in6_dev->addr_list, if_list) {
		struct sockaddr_in6 bind_addr;

		if (ipv6_addr_any(&s_laddr->sin6_addr) ||
		    ipv6_addr_equal(&s_laddr->sin6_addr, &ifp->addr)) {
			bind_addr.sin6_family = AF_INET6;
			bind_addr.sin6_port = s_laddr->sin6_port;
			bind_addr.sin6_flowinfo = 0;
			bind_addr.sin6_addr = ifp->addr;
			bind_addr.sin6_scope_id = dev->ifindex;
				rv = siw_listen_address(id, backlog,
					(struct sockaddr *)&bind_addr,
					AF_INET6);
			if (!rv)
				listeners++;
		}
	}
	read_unlock_bh(&in6_dev->lock);

siw_listen_address() calls sock_create(). I don't think it is allowed to 
call sock_create() from atomic context.

Thanks,

Bart.

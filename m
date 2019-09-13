Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C2E1FB284E
	for <lists+linux-rdma@lfdr.de>; Sat, 14 Sep 2019 00:25:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404010AbfIMWZQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 13 Sep 2019 18:25:16 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38858 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403866AbfIMWZQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 13 Sep 2019 18:25:16 -0400
Received: by mail-pf1-f195.google.com with SMTP id h195so18953888pfe.5;
        Fri, 13 Sep 2019 15:25:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gm8JRIhpyrMex2SYzcH56dJGZZjLQQAlUO4hYFFwY9g=;
        b=qp/JFCvOUaSmmg9tUSK+i881nORMjQzb0fwMEwsHo0KUT2LQHRJMA8T84azMaSDQWe
         eViX/Gu9JtowslkbYiH3hvR4qCBkA1CrEia/E09q9LMnl9X/+fvX42jBsb5AwyPj3FKa
         nLIyZIRQFuUrDCStC2HSr6/r6AJcQhUwplUw2EPfqNQFJemEmu5i4PfRW/+TRN9y3BCQ
         G21JwEdsHupDtAm7nW56XUkh3cT3KpsyIduVJxcUO6Lhb/RgPNJ2mckrd3OSO1Z8YaNf
         1Sq9mGa4lk5tU3o98flDwyW1p2J/e5kbfee5x0V7avetlFBHhiUqme4EbBm6z6OD8KXV
         RcKg==
X-Gm-Message-State: APjAAAXvGs14LJAEeeT/5I6ucDymR0zYEVVtegjkf0Ywxhwee/hulxty
        1HCqmc0Xp7mHz+XAIB5Uy68=
X-Google-Smtp-Source: APXvYqxs0RBpSUXgvVkbc9lHZRFUOnt606yK3ICQzcphKxkTjNXSl1ps0LJP5iGr9EMnqHne7QAvNg==
X-Received: by 2002:a63:8942:: with SMTP id v63mr18713902pgd.58.1568413515357;
        Fri, 13 Sep 2019 15:25:15 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id n9sm30553722pfa.154.2019.09.13.15.25.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Sep 2019 15:25:14 -0700 (PDT)
Subject: Re: [PATCH v4 16/25] ibnbd: client: private header with client
 structs and functions
To:     Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        jgg@mellanox.com, dledford@redhat.com,
        danil.kipnis@cloud.ionos.com, rpenyaev@suse.de,
        Roman Pen <roman.penyaev@profitbricks.com>,
        Jack Wang <jinpu.wang@cloud.ionos.com>
References: <20190620150337.7847-1-jinpuwang@gmail.com>
 <20190620150337.7847-17-jinpuwang@gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <7d11d903-7826-8c1a-bef8-74ea4cf5f340@acm.org>
Date:   Fri, 13 Sep 2019 15:25:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190620150337.7847-17-jinpuwang@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 6/20/19 8:03 AM, Jack Wang wrote:
> +	char			pathname[NAME_MAX];
[ ... ]
 > +	char			blk_symlink_name[NAME_MAX];

Please allocate path names dynamically instead of hard-coding the upper 
length for a path.

Bart.

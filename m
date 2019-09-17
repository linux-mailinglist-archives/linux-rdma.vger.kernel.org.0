Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DDD15B54C8
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Sep 2019 19:59:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726996AbfIQR7L (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 17 Sep 2019 13:59:11 -0400
Received: from mail-pg1-f170.google.com ([209.85.215.170]:33017 "EHLO
        mail-pg1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbfIQR7L (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 17 Sep 2019 13:59:11 -0400
Received: by mail-pg1-f170.google.com with SMTP id n190so2431532pgn.0
        for <linux-rdma@vger.kernel.org>; Tue, 17 Sep 2019 10:59:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jsQ7CwmpOwFZ9SEJivcYuQ2uZq/YXm72KB9P5StyPto=;
        b=N7ob3omNri/F1xUrqmST96e8dbCQHORkyGPn80nGjgVa1ag45jTMAuczgD81EUHOt2
         SKSRfluzOjD6qUVbQ1ISXIkde2VPqijdpjQD2CaTcXjueT38ABTT4Kv3PUx7AHnE5HSP
         cEY9G5gQxK/8yB9+IbiYnSglO6hHeLhkuybPkQw7sw2giMs+oC8QfF/LTZssAbi29dtQ
         sO0SqRLOwUCoLvWYvXZ4kEqHTjFGrHngGVwBLdE60+eeqAQHqhGPvhDgqgmBZlQsCKos
         ncexwysupL0bqslAIdn3O+pJJMTznE+YRx10UhClNPTC+bS69WQpqoikR7zYgPwqlk/5
         DFVQ==
X-Gm-Message-State: APjAAAXvCW7kgyQ36YlMC9n57igBTjCTB5pNyEllcikhV5AcmQQsi9cd
        eSVlcDKLQnLme1Y13uF5aDc=
X-Google-Smtp-Source: APXvYqykYlJfkn4P4dnn0a0/HbODMIVDO+EZ9Q+B4M9P8iASarKgqI60chPVVa2ezgntPCzGzCJmzA==
X-Received: by 2002:aa7:94af:: with SMTP id a15mr5602538pfl.157.1568743151136;
        Tue, 17 Sep 2019 10:59:11 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id r18sm3510814pfc.3.2019.09.17.10.59.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Sep 2019 10:59:10 -0700 (PDT)
Subject: Re: 5.3-rc8 tests all pass with RDMA/SRP testing
To:     Laurence Oberman <loberman@redhat.com>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        "Dutile, Don" <ddutile@redhat.com>
Cc:     Rupesh Girase <rgirase@redhat.com>
References: <3d41038fc1e720937606589d1ba91591486dd548.camel@redhat.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <c9e449ab-23d6-0036-7056-8c49e4efdf0b@acm.org>
Date:   Tue, 17 Sep 2019 10:59:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <3d41038fc1e720937606589d1ba91591486dd548.camel@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 9/12/19 12:48 PM, Laurence Oberman wrote:
> My usual 3 month SRP test results show all is still well with SRP
> client drivers and multipath.
> I am still using 4.16 for the ib_srpt on the target server.
> 
> 5.3-rc8 ib_srp CX4 100Gbit EDR tests
> direct and unbuffered, large and small I/O sizes
> port recovery with fault injection
> 
> One small observation was that after fault injection it seemed to take
> longer to log back in, in that I needed to extend my sleep in the
> injection script to avoid some multipaths lose all paths.
> 
> I was sleeping 30s between resets prior to this and I would log back in
> quick enough to not lose all paths.
> My sleep is now 60s
> 
> #on ibclient server in /sys/class/srp_remote_ports, using echo 1 >
> delete for the particular port will simulate a port reset.
> 
> #/sys/class/srp_remote_ports
> #[root@ibclient srp_remote_ports]# ls
> #port-1:1  port-2:1
> for d in /sys/class/srp_remote_ports/*
> do
> 	echo 1 > $d/delete
> sleep 60
> done

Hi Laurence,

This is weird. Has this behavior change been observed once or has it 
been observed multiple times? I'm asking because in my tests I noticed 
that there can be variation between tests depending on how much time the 
SCSI error handler spends in its error recovery strategy.

Thanks,

Bart.

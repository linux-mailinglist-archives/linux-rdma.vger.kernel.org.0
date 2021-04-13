Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F4BE35E0B0
	for <lists+linux-rdma@lfdr.de>; Tue, 13 Apr 2021 15:56:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231589AbhDMN4b (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 13 Apr 2021 09:56:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:60220 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229741AbhDMN4b (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 13 Apr 2021 09:56:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618322171;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MLAZhk+pyuml0urAdbPyvsgfZfDI2WhK5G1bd71kbE4=;
        b=N06LsPZpnM0vie0P4l0fl3dDIGPDvJ2SlYHiMELTyijBeQv9z5JiiBfPTTOiM7QuhLxyfH
        4equoSwvlL0cLdOEjATKrrGZsd8hsSwJuQllj4PMuIm/uksvqLEIBMDjqWnb5bQ6rTJstF
        eQlh2zkkbBiBwHJT8kK0m30LNJCFAVA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-34-N82Sc8ysNuyZw1oIES4zXQ-1; Tue, 13 Apr 2021 09:56:09 -0400
X-MC-Unique: N82Sc8ysNuyZw1oIES4zXQ-1
Received: by mail-wr1-f69.google.com with SMTP id t17so802832wrn.12
        for <linux-rdma@vger.kernel.org>; Tue, 13 Apr 2021 06:56:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MLAZhk+pyuml0urAdbPyvsgfZfDI2WhK5G1bd71kbE4=;
        b=Z7DO6wNhDJii/5WyVEX5i3CMRGBtWem5Op9sEvZL0QkDQZCK6VrWNCDH7fS2qCpScv
         AePswy0xQkL4VaoKrfugXhy+OT3qhIjQPMfTbcMwX4vtbC1bmLi/ogNUJ6slR00/kuYF
         icnHeFaPrHZXAKskYI0Tj/TZNPHd4YnTBr+2cULIM1ALBTvt6qWKE4J2G+vYeYEPUTgt
         Hpg2y7PSGETi9ELFUgdRNcOmWku8MYYd3x1kPupsHQv9ncRTfk/SzTG8yOEIzMFlu/5w
         22lTygIwi3yPXYXFIqJXmSK5+Mrn7ZpcuaYXif/TW4Lo90+cjrG0Jy7SMyDrYD3b1olb
         iaWw==
X-Gm-Message-State: AOAM532YRJbBxGL0ITCwPBi4eLJEP52QNFIxOo5SWVIr3q1MOY1Hs3qx
        WFF8HPm8VWSjEJS+S4RPXj7ZGyBKlzplHOWQyYcUCtXv81sQg4b6362Bn9Q0owLc9zSf3IIiAYX
        1ElzmVFRsBpLXzxqdf5FLow==
X-Received: by 2002:a5d:6ace:: with SMTP id u14mr2244516wrw.322.1618322168151;
        Tue, 13 Apr 2021 06:56:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJypjMKt9CdOApFpmiZfCgZ7YRAgvNrqk5cD92eo9Ig7NqEUj40QysbXAFaA8fvEILSat04Miw==
X-Received: by 2002:a5d:6ace:: with SMTP id u14mr2244491wrw.322.1618322167902;
        Tue, 13 Apr 2021 06:56:07 -0700 (PDT)
Received: from [192.168.68.110] ([5.29.16.216])
        by smtp.gmail.com with ESMTPSA id x2sm11993516wrg.31.2021.04.13.06.56.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Apr 2021 06:56:07 -0700 (PDT)
Subject: Re: [PATCHv5 for-next 1/1] RDMA/rxe: Disable ipv6 features when
 ipv6.disable in cmdline
To:     Zhu Yanjun <yanjun.zhu@intel.com>, zyjzyj2000@gmail.com
Cc:     Yi Zhang <yi.zhang@redhat.com>, dledford@redhat.com,
        linux-rdma@vger.kernel.org, jgg@ziepe.ca
References: <20210413234252.12209-1-yanjun.zhu@intel.com>
From:   Kamal Heib <kheib@redhat.com>
Message-ID: <ad1ca691-2d7f-905a-2a41-818f6cc34c50@redhat.com>
Date:   Tue, 13 Apr 2021 16:56:05 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210413234252.12209-1-yanjun.zhu@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 4/14/21 2:42 AM, Zhu Yanjun wrote:
> From: Zhu Yanjun <zyjzyj2000@gmail.com>
> 
> When ipv6.disable=1 is set in cmdline, ipv6 is actually disabled
> in the stack. As such, the operations of ipv6 in RXE will fail.
> So ipv6 features in RXE should also be disabled in RXE.
> 
> Link: https://lore.kernel.org/linux-rdma/880d7b59-4b17-a44f-1a91-88257bfc3aaa@redhat.com/T/#t
> Fixes: 8700e3e7c4857 ("Soft RoCE driver")
> Reported-by: Yi Zhang <yi.zhang@redhat.com>
> Signed-off-by: Zhu Yanjun <zyjzyj2000@gmail.com>
> ---
> V4->V5: Clean up signature block and remove error message
> V3->V4: Check the returned value instead of ipv6 module
> V2->V3: Remove print message
> V1->V2: Modify the pr_info messages
> ---
>  drivers/infiniband/sw/rxe/rxe_net.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rxe/rxe_net.c
> index 01662727dca0..984c3ac449bd 100644
> --- a/drivers/infiniband/sw/rxe/rxe_net.c
> +++ b/drivers/infiniband/sw/rxe/rxe_net.c
> @@ -208,7 +208,13 @@ static struct socket *rxe_setup_udp_tunnel(struct net *net, __be16 port,
>  	/* Create UDP socket */
>  	err = udp_sock_create(net, &udp_cfg, &sock);
>  	if (err < 0) {
> -		pr_err("failed to create udp socket. err = %d\n", err);
> +		/* If UDP tunnel over ipv6 fails with -EAFNOSUPPORT, the tunnel
> +		 * over ipv4 still works. This error message will not pop out.
> +		 * If UDP tunnle over ipv4 fails or other errors with ipv6
> +		 * tunnel, this error should pop out.
> +		 */
> +		if (!((err == -EAFNOSUPPORT) && (ipv6)))
> +			pr_err("failed to create udp socket. err = %d\n", err);
>  		return ERR_PTR(err);
>  	}
>  
> @@ -620,6 +626,11 @@ static int rxe_net_ipv6_init(void)
>  	recv_sockets.sk6 = rxe_setup_udp_tunnel(&init_net,
>  						htons(ROCE_V2_UDP_DPORT), true);
>  	if (IS_ERR(recv_sockets.sk6)) {
> +		/* Though IPv6 is not supported, IPv4 still needs to continue
> +		 */
> +		if (PTR_ERR(recv_sockets.sk6) == -EAFNOSUPPORT)
> +			return 0;
> +
>  		recv_sockets.sk6 = NULL;
>  		pr_err("Failed to create IPv6 UDP tunnel\n");
>  		return -1;
> 

I think the following change is much simpler than changing the udp_sock_create()
helper function?


diff --git a/drivers/infiniband/sw/rxe/rxe_net.c
b/drivers/infiniband/sw/rxe/rxe_net.c
index 01662727dca0..b56d6f76ab31 100644
--- a/drivers/infiniband/sw/rxe/rxe_net.c
+++ b/drivers/infiniband/sw/rxe/rxe_net.c
@@ -621,6 +621,11 @@ static int rxe_net_ipv6_init(void)
                                                htons(ROCE_V2_UDP_DPORT), true);
        if (IS_ERR(recv_sockets.sk6)) {
                recv_sockets.sk6 = NULL;
+               if (PTR_ERR(recv_sockets.sk6) == -EAFNOSUPPORT) {
+                       pr_warn("Create IPv6 UDP tunnel is not supported\n");
+                       return 0;
+               }
+
                pr_err("Failed to create IPv6 UDP tunnel\n");
                return -1;
        }
-- 
2.26.3


Thanks,
Kamal


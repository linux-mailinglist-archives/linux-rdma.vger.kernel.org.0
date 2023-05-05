Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA0A46F872B
	for <lists+linux-rdma@lfdr.de>; Fri,  5 May 2023 18:59:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbjEEQ7h (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 5 May 2023 12:59:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbjEEQ7g (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 5 May 2023 12:59:36 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 841C330EE
        for <linux-rdma@vger.kernel.org>; Fri,  5 May 2023 09:59:35 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-64389a44895so1750540b3a.1
        for <linux-rdma@vger.kernel.org>; Fri, 05 May 2023 09:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20221208.gappssmtp.com; s=20221208; t=1683305975; x=1685897975;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TAdX7eg2ryjY56yRTcHERosjHmSEk4LPOkzOv4IolK4=;
        b=bMx0T2PEF73qajo+15koX2YRbehw38va851NXwnFtJ+mx7MFBGachyQS2rCSICBrJD
         nKl3fDRQ6PZZDEISPPiQZSRzx4rCQzf/9u6ObKtD99AUSrcE4OU8Vj3SvaXrc1Zpi59B
         UV63xHiILreJPwcB+0X2kpT7RwwK9XRo7b5AkpqRuRy3XspTbIVhbzCLZgFvamWVn2fL
         H+BHrFUyixTE6Zdvitgjhunz5DILR+NuAYE7b4iXO+wUA/9SVOhZ406miG+13lhozflK
         69B6dLb2TbWAICKHUngAXvDN+oZP9xOvotR9ROA2y7V/IGbBS1i7UNa/z2iTCPVGWiea
         529A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683305975; x=1685897975;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TAdX7eg2ryjY56yRTcHERosjHmSEk4LPOkzOv4IolK4=;
        b=A2ZUuJTo5uaj+87nmOJLDhPURVtGujQP4xwAEPxnCi5haOz1Qnc6o3vq8mw5fSWwvv
         LRL0BHOzFDLpCbNIryt6kvvtA7LmNQjgOeK6cZsVbOCUisPE9ErkySWbQMAY/7191t3/
         z9q/ItCJaoVY2V6FwbxwiVmyL8S63oTD9bY/hjZ4E6WIut5JAfGR0qi5IUv6Si5397Ll
         BwWiLnmrQr4ZHRJB+Bkv7Yt/9mlOeflyq4LwpFU9A2nrohp4JXTI6F7lRQxmgPeFo/It
         vAyXI2/OldXF5ZZ7mRQ205O0wOUzArvwkAl+OkpTVU8gt9ivYJTFfRDPiFzBz0/5rF/P
         ppzQ==
X-Gm-Message-State: AC+VfDwMJgUnqOsIDIHJRpjaLc3jIZ+6XMsynW4v5KmYG3uf76REzW9+
        vPZMlA9nLSah3U+aEaov5V2YiZU5Qb5rP/tjj+3rCA==
X-Google-Smtp-Source: ACHHUZ6FUzTYBCIMDTxJQxEa7xuKlQSBcvVlbcrDNPig9DMVntIYVrpgeqpY9QAuZ9kNhIc+Tjh/BQ==
X-Received: by 2002:a05:6a20:4305:b0:f0:219e:f11c with SMTP id h5-20020a056a20430500b000f0219ef11cmr2887725pzk.31.1683305975026;
        Fri, 05 May 2023 09:59:35 -0700 (PDT)
Received: from hermes.local (204-195-120-218.wavecable.com. [204.195.120.218])
        by smtp.gmail.com with ESMTPSA id c25-20020aa78819000000b0064394d63458sm1871685pfo.78.2023.05.05.09.59.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 May 2023 09:59:34 -0700 (PDT)
Date:   Fri, 5 May 2023 09:59:32 -0700
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     Chuck Lever <cel@kernel.org>
Cc:     netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
        BMT@zurich.ibm.com, tom@talpey.com
Subject: Re: [PATCH RFC 1/3] net/tun: Ensure tun devices have a MAC address
Message-ID: <20230505095932.4025d469@hermes.local>
In-Reply-To: <168330132769.5953.7109360341846745035.stgit@oracle-102.nfsv4bat.org>
References: <168330051600.5953.11366152375575299483.stgit@oracle-102.nfsv4bat.org>
        <168330132769.5953.7109360341846745035.stgit@oracle-102.nfsv4bat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, 05 May 2023 11:42:17 -0400
Chuck Lever <cel@kernel.org> wrote:

> From: Chuck Lever <chuck.lever@oracle.com>
> 
> A non-zero MAC address enables a network device to be assigned as
> the underlying device for a virtual RDMA device. Without a non-
> zero MAC address, cma_acquire_dev_by_src_ip() is unable to find the
> underlying egress device that corresponds to a source IP address,
> and rdma_resolve_address() fails.
> 
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  drivers/net/tun.c |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index d4d0a41a905a..da85abfcd254 100644
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c
> @@ -1384,7 +1384,7 @@ static void tun_net_initialize(struct net_device *dev)
>  
>  		/* Point-to-Point TUN Device */
>  		dev->hard_header_len = 0;
> -		dev->addr_len = 0;
> +		dev->addr_len = ETH_ALEN;
>  		dev->mtu = 1500;
>  
>  		/* Zero header length */

This is a bad idea.
TUN devices are L3 devices without any MAC address.
This patch will change the semantics and break users.

If you want an L2 address, you need to use TAP, not TUN device.

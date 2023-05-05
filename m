Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CC666F8724
	for <lists+linux-rdma@lfdr.de>; Fri,  5 May 2023 18:57:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231326AbjEEQ5b (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 5 May 2023 12:57:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbjEEQ53 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 5 May 2023 12:57:29 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED4FA19925
        for <linux-rdma@vger.kernel.org>; Fri,  5 May 2023 09:57:21 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1aad5245632so14368655ad.3
        for <linux-rdma@vger.kernel.org>; Fri, 05 May 2023 09:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20221208.gappssmtp.com; s=20221208; t=1683305841; x=1685897841;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MRnH3Cqyhep5CEq8cjj0HvIYZ//rx8xK1w3m3boBFtg=;
        b=Cyf/IQwjmN9nQoPYngzzVl136RZUda/4n2mxEslQE6sZXsNPA8HPj7FUmIk4yH/+Ul
         CGE5+hMHUuhvWiMrdhcQ/HHILkaTdCVWE2E1FFRP15KyTbmDfuaSgT46WsKX6jjnhdCc
         qZN4gR2llEQKeHIA3LEIWEO2NOvJd0J2Yv2QhCa8uDlEG4Z6y2RzMgVkL01DBdbuaqoE
         t7wEXYL4RYq3GDXOjJ5w3vEJguzJSKRMLOSN65oWtMlSTHjTj4gmbgwHmETw67ZtZINV
         88UsYbpmdrEPjoEyvb7s9l3l5iSdgBRIPPuuERshVM37DqaUym8OWO4n72s9AR5DfuMD
         4w1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683305841; x=1685897841;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MRnH3Cqyhep5CEq8cjj0HvIYZ//rx8xK1w3m3boBFtg=;
        b=hp3ZxUkTrXVs26tmRyncyObYLQJtWjOX/jviUYz5hfjki7xhKpBnCPJcRgNplTa9iy
         YCWihf4esCYNmPW9TKnTVTCZ96W27OGp9ek/l1qbPtDWu2pEk2RZ1FoIiH87bCf/n7cD
         UaV8q3idfULUloBPuIWR2NXEfK4l0ReAyDGtIrDqNJwPGL0M6/7SBh1m0LQcsbRers6g
         hSQ6g/HRF/Ebvb2CJx55Mc2cytX7HPFV9yAkx/LzNWS78L5LHF0N8VfVY9V4f7NpIWt5
         NyLRkKXTsmPdhKrgCiFonVGCzZPAqYICnYXJ8JDLcLLgVX/fqo5UOtQUrSgr9W7F9ERl
         HivQ==
X-Gm-Message-State: AC+VfDzAubqDpbBFNzojUPRqfLyedlb2GXQS83hhGb1Igocy7Zk7mBN5
        P0IQGJ41vqKajmBDEmrdrtLzxw==
X-Google-Smtp-Source: ACHHUZ7LKP3CgdJgRxrVJzoZS412nCrFH/uVDLZE6eaj78oMi5iMd/a/L1rEOrB3ZxMOJ5q/i06cTg==
X-Received: by 2002:a17:902:be01:b0:1a8:1c9a:f68 with SMTP id r1-20020a170902be0100b001a81c9a0f68mr1814959pls.36.1683305841239;
        Fri, 05 May 2023 09:57:21 -0700 (PDT)
Received: from hermes.local (204-195-120-218.wavecable.com. [204.195.120.218])
        by smtp.gmail.com with ESMTPSA id w1-20020a170902904100b001a69c1c78e7sm2017229plz.71.2023.05.05.09.57.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 May 2023 09:57:20 -0700 (PDT)
Date:   Fri, 5 May 2023 09:57:17 -0700
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     Chuck Lever <cel@kernel.org>
Cc:     netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
        BMT@zurich.ibm.com, tom@talpey.com
Subject: Re: [PATCH RFC 2/3] net/lo: Ensure lo devices have a MAC address
Message-ID: <20230505095717.6ad2b4ca@hermes.local>
In-Reply-To: <168330135435.5953.3471584034284499194.stgit@oracle-102.nfsv4bat.org>
References: <168330051600.5953.11366152375575299483.stgit@oracle-102.nfsv4bat.org>
        <168330135435.5953.3471584034284499194.stgit@oracle-102.nfsv4bat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, 05 May 2023 11:42:44 -0400
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
>  drivers/net/loopback.c |    2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/net/loopback.c b/drivers/net/loopback.c
> index f6d53e63ef4e..1ce4f19d8065 100644
> --- a/drivers/net/loopback.c
> +++ b/drivers/net/loopback.c
> @@ -192,6 +192,8 @@ static void gen_lo_setup(struct net_device *dev,
>  	dev->needs_free_netdev	= true;
>  	dev->priv_destructor	= dev_destructor;
>  
> +	eth_hw_addr_random(dev);
> +
>  	netif_set_tso_max_size(dev, GSO_MAX_SIZE);
>  }
>  
> 
> 
> 

This enough of a change, it will probably break somebody.
If you need dummy endpoint (ie multiple loopback), a common way
is to use dummy devices for that.

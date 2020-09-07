Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 943782600E0
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Sep 2020 18:55:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730855AbgIGQz2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 7 Sep 2020 12:55:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731197AbgIGQzZ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 7 Sep 2020 12:55:25 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B736BC061574
        for <linux-rdma@vger.kernel.org>; Mon,  7 Sep 2020 09:55:21 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id y15so2162191wmi.0
        for <linux-rdma@vger.kernel.org>; Mon, 07 Sep 2020 09:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TC5nGh2DXu2of5ESJ+7oCayiPuO8sTu7DoaLMu3a+0Q=;
        b=N6k3/zT+wwcRjqYRkyDLhFg6/7NEos8vn6HmuOSTqKLw8mDILrMJXD13ehiCAShhb2
         lQDOlH7+NXF/k879ru49UTOSNWmAFMPifuhI7CmNRfAf0CGZ3ikyGeCbcjpUC0M28FZG
         WoPIu/y6omg4sMrkPpDzG8RqW9/xJWejggkDwtgIFTu07RtB76L/2Sn+VZrS+Bxkd5IE
         JSl8B/sjYAJeC/CjTOFINgsOLJGTSrIOi0r00A7kQQ+TQYzKGldrszKLVt0w79aimfsr
         ci7akVf1ssrlrTEZW2LHI00c8EaZYWJdPJicQB5hm2gfgWZ6BjPRycLFbb4h5G+H17DH
         xAVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TC5nGh2DXu2of5ESJ+7oCayiPuO8sTu7DoaLMu3a+0Q=;
        b=folk+6KqX3bXljip8TQ/qOgQgmRzUCVL8qE+UaepiSXKbiTCLLSD9hAAlFZTOzZMp1
         zQJSvoj7QJlk1QVFknTTFkoOWwDHPyI+ztbCAdodmn8Iu6PRuCLMyLtJwfUCGdz2WOzV
         FZgqcnejO2lwdq/ElPcGWoWVf6cY2L9Ul9hKhtOpd0B1q1xLBTt6V0MsAvi8v/sorI/3
         LsyXXyWJn799g3/lA5CxOObfaqplrKwCUWXtnmBnaFJZ7OQcWBaUrYXBPUZ70g9SmJE8
         Sp/rU/WvmfNEKf+Pr+1/aPTm1mo5WWBKcKqUfJ5UsMtsDVUi7Det3gqpNgHu6jfX1bNn
         7Ntw==
X-Gm-Message-State: AOAM531cyDHe1wy8JumSprbB4TjNJODilgVKYUMrD2Y52cypIVkTxRXN
        uJhAVwEldP/ABbtYkFAG8HjvBwCFxBi3DKdx
X-Google-Smtp-Source: ABdhPJwKqdOIpjPHDLHBXrk922rhECkTYNUW/PCD8TzZI7z+U8iflbP5Gs++mTB3PTPfqn9ngTQT/A==
X-Received: by 2002:a05:600c:204e:: with SMTP id p14mr224249wmg.182.1599497719750;
        Mon, 07 Sep 2020 09:55:19 -0700 (PDT)
Received: from localhost ([86.61.181.4])
        by smtp.gmail.com with ESMTPSA id k24sm27671157wmj.19.2020.09.07.09.55.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2020 09:55:19 -0700 (PDT)
Date:   Mon, 7 Sep 2020 18:55:18 +0200
From:   Jiri Pirko <jiri@resnulli.us>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Leon Romanovsky <leon@kernel.org>, davem@davemloft.net,
        netdev@vger.kernel.org, kernel-team@fb.com, tariqt@mellanox.com,
        yishaih@mellanox.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH net-next] mlx4: make sure to always set the port type
Message-ID: <20200907165518.GM2997@nanopsycho.orion>
References: <20200904200621.2407839-1-kuba@kernel.org>
 <20200906072759.GC55261@unreal>
 <20200906093305.5c901cc5@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <20200907062135.GJ2997@nanopsycho.orion>
 <20200907064830.GK55261@unreal>
 <20200907071939.GK2997@nanopsycho.orion>
 <20200907093401.547ae9b8@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200907093401.547ae9b8@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Mon, Sep 07, 2020 at 06:34:01PM CEST, kuba@kernel.org wrote:
>On Mon, 7 Sep 2020 09:19:39 +0200 Jiri Pirko wrote:
>> >The port type is being set to IB or ETH without relation to net_device,
>> >fixing it will require very major code rewrite for the stable driver
>> >that in maintenance mode.  
>> 
>> Because the eth driver is not loaded, I see. The purpose of the
>> WARN in devlink_port_type_eth_set is to prevent drivers from registering
>> particular port without netdev/ibdev. That is what was repeatedly
>> happening in the past as the driver developers didn't know they need to
>> do it or were just lazy to do so.
>> 
>> I wonder if there is any possibility to do both...
>
>I think we have two options in this case:
> - set type to eth without the netdev
> - selectively mute the warning
>
>I think the former is better, because we still want to see what the
>port type is. Perhaps we should add a:
>
>  dev_warn("devlink port type set without software interface
>            reference, device type not supported by the kernel?");
>
>That way people won't just pass NULL out of laziness, hopefully.
>
>WDYT?

Okay. That sounds probably like the best option we have.

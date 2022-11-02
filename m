Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 669FA615FD1
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Nov 2022 10:33:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbiKBJdA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 2 Nov 2022 05:33:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230241AbiKBJc6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 2 Nov 2022 05:32:58 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E927A1403A
        for <linux-rdma@vger.kernel.org>; Wed,  2 Nov 2022 02:32:56 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id f5so22144410ejc.5
        for <linux-rdma@vger.kernel.org>; Wed, 02 Nov 2022 02:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RV2bi+Arg3PPh2gmWVESDVUwH/ZtxQUyDYdE3wwmynk=;
        b=LzC7PqYowNtWtKrB7MpbozFX/0KKlidIXFWdjUF/PzqypiZE3ppmsRQ2NY/Tv4GhIx
         RmVC28gEkgxyBlyb+Wdszxv/J5INcITr3rRd21Rm3RYACszV2NCgBcAQ2YAm7AJKg6E+
         W/V6Dz6YTt6++WrEkhQFrGge7o4VHpBsj9MgQaynf3ic8xCG6HErzC5FceiLp0U362Ty
         B+LmGKv2iGyqyJfRgIDRjV6x/KPeXzoI2P1QjmfzJ81FvXB/Z1RTy2UiU6kdwGUcfgG1
         iaNrSSxrVXs1Fu3u/HF/mQVth7HnwX8VpiVHO/rJyYxbPE3LFM5dQ5G3WhH2zGuEnWGr
         Ad+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RV2bi+Arg3PPh2gmWVESDVUwH/ZtxQUyDYdE3wwmynk=;
        b=NDs5SXazkr1V7JAlZ9dYqCf2XpVbOZmFh9I1II4FWSw2n27yDsX7xUUPdwFiofukF4
         c8NzKheji/yv0GR6vW3j4Fc/ABiEJ8ZuQAKoYoasgAD6zM0s225/lF73xHoYsMtNtSlD
         YNUupv2DP6jsWm7KBc43fdM55m+AcDwordyklDaqfqqoeXwzCiKdfa8bzj0fvqY2TPgG
         a44UeLRXg8SlR2TUWo49JH2RBc24subyRGFITNjzM/nDUR7x6WFN9yTuGle0BS1sx4al
         hDZK+QLa/tbkK4scl2JS3BhN12swWokcb0zHLJK0UX3c3O3S9t4eiJgx/goRCGX60zjA
         k8Zw==
X-Gm-Message-State: ACrzQf0RJ17Qt2I58uIsGG8r44rG2tb4paORCvp2dZxyYWm/sc0tXUKl
        lJnuoGme7Yx5O3nlyCE2YqidMg==
X-Google-Smtp-Source: AMsMyM6yvI2slLDREEHpW0fkIE/dvGcddUP6M0Z0pmFGZeBg94FTPohCq/nTSyJ+kC6q/O3FmzY6+g==
X-Received: by 2002:a17:906:5a6e:b0:7ad:9303:65da with SMTP id my46-20020a1709065a6e00b007ad930365damr23497401ejc.638.1667381575298;
        Wed, 02 Nov 2022 02:32:55 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id 16-20020a170906329000b0073ddb2eff27sm5112047ejw.167.2022.11.02.02.32.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 02:32:54 -0700 (PDT)
Date:   Wed, 2 Nov 2022 10:32:52 +0100
From:   Jiri Pirko <jiri@resnulli.us>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     netdev@vger.kernel.org, davem@davemloft.net, pabeni@redhat.com,
        edumazet@google.com, tariqt@nvidia.com, moshe@nvidia.com,
        saeedm@nvidia.com, linux-rdma@vger.kernel.org
Subject: Re: [patch net-next v3 05/13] net: devlink: track netdev with
 devlink_port assigned
Message-ID: <Y2I5RD6zPDr3MGpG@nanopsycho>
References: <20221031124248.484405-1-jiri@resnulli.us>
 <20221031124248.484405-6-jiri@resnulli.us>
 <20221101092542.26c66235@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221101092542.26c66235@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Tue, Nov 01, 2022 at 05:25:42PM CET, kuba@kernel.org wrote:
>On Mon, 31 Oct 2022 13:42:40 +0100 Jiri Pirko wrote:
>> +/*
>> + * Driver should use this to assign devlink port instance to a netdevice
>> + * before it registers the netdevice. Therefore devlink_port is static
>> + * during the netdev lifetime after it is registered.
>> + */
>> +#define SET_NETDEV_DEVLINK_PORT(dev, _devlink_port)		\
>> +({								\
>> +	WARN_ON(dev->reg_state != NETREG_UNINITIALIZED);	\
>> +	((dev)->devlink_port = (_devlink_port));		\
>> +})
>
>The argument wrapping is inconsistent here - dev is in brackets
>on the second line but not on the first. _devlink_port is prefixed 
>with underscore and dev is not. Let's make this properly secure
>and define a local var for dev.

Ok.


>
>> @@ -10107,6 +10107,7 @@ int register_netdevice(struct net_device *dev)
>>  	return ret;
>>  
>>  err_uninit:
>> +	call_netdevice_notifiers(NETDEV_PRE_UNINIT, dev);
>
>I think we should make this symmetric with POST_INIT.
>IOW PRE_UNINIT should only be called if POST_INIT was called.

Yep, will check and fix.


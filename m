Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 025D76166BC
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Nov 2022 16:59:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbiKBP7l (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 2 Nov 2022 11:59:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231204AbiKBP7d (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 2 Nov 2022 11:59:33 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09CD62BB1F
        for <linux-rdma@vger.kernel.org>; Wed,  2 Nov 2022 08:59:31 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id c3-20020a1c3503000000b003bd21e3dd7aso1586985wma.1
        for <linux-rdma@vger.kernel.org>; Wed, 02 Nov 2022 08:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0HmwDVoTDX878bFuiu5Mhipe13o11Sl5lwKQ0r0neCY=;
        b=UkQFO/+jC/3eP2DwDSMaWAqMxngNl1Q/8hz/vQ4MnJ/VF05+snfK0t/zVuei969EBd
         9eXamExZu/bMwN0EcSeaaAG0z/87t/tzRqq+03LUIuWNH71Ih/8cdO8oX9HHqxVjqU2x
         GUrayt4RD5//8cu9/17vWzZqDQTWVUZ4WaqapCvL2UsP5j3DGAWNStHwIMoB3wfEUihy
         HzQOcDkoxAaoAuSjeA6zVzjkD60xJV6xKs/ywondft+Z+4IkhEc3ZJbdH8J8KfQJx7m9
         o9nbJdQGIW36wqNPmG5d11p435X+evAOaoEXYaUc3b2X7ErWigr3Y3M+7AKzUM0Qy5hC
         9aDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0HmwDVoTDX878bFuiu5Mhipe13o11Sl5lwKQ0r0neCY=;
        b=nPNNS4ADk5kwMEgrI618RwwOzf1Dq80Cp6PQo2lzqy7tJ8Eyn8ST/xWC7nsMijKhJD
         YFZ4nuGKtt6X6asCXyM6bwf7yW8ethpzginHVXWn1OO/HYkuaEBgfqm5hfrxmB2FeQkV
         THPWseRpmHP8ESnV/lj2ZAXu5nwvzKzwVf0+nH6+cLYm0VcH5wbOiT3duXVBiVrbr5eb
         z0t6pM8zgZTHsA1YX3uji9kacuI3fO2AJnRSA7hMiU5hPR/ddnNXU7NzH9iIAkKVI2CC
         0W3DpACVNgv3tZ+IH7bWfArQmclNxxPM+c5/O2D6++HQ+IzjKyqEQ74pVL3jbzrhXndc
         lLkQ==
X-Gm-Message-State: ACrzQf2zMxX/u8eIYwyvExjy0jWuF/tKPFbYkiKx1gHVG5gJLGitmJqK
        K4e7WFSsmjq6jF9hhRAXp1XwMQ==
X-Google-Smtp-Source: AMsMyM7zWKcp/TeVAVxaVtJ8/1a12InfD2858PbjVhxuwHUTn05c8BBvmtDS829RbZz6TLXImYytHQ==
X-Received: by 2002:a05:600c:3547:b0:3cf:7a9f:d6cd with SMTP id i7-20020a05600c354700b003cf7a9fd6cdmr8395608wmq.30.1667404770346;
        Wed, 02 Nov 2022 08:59:30 -0700 (PDT)
Received: from localhost ([86.61.181.4])
        by smtp.gmail.com with ESMTPSA id bj12-20020a0560001e0c00b0022e55f40bc7sm13431874wrb.82.2022.11.02.08.59.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 08:59:29 -0700 (PDT)
Date:   Wed, 2 Nov 2022 16:59:28 +0100
From:   Jiri Pirko <jiri@resnulli.us>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     netdev@vger.kernel.org, davem@davemloft.net, pabeni@redhat.com,
        edumazet@google.com, tariqt@nvidia.com, moshe@nvidia.com,
        saeedm@nvidia.com, linux-rdma@vger.kernel.org
Subject: Re: [patch net-next v3 13/13] net: expose devlink port over rtnetlink
Message-ID: <Y2KT4A6ZGVfcbsfx@nanopsycho>
References: <20221031124248.484405-1-jiri@resnulli.us>
 <20221031124248.484405-14-jiri@resnulli.us>
 <20221101091834.4dbdcbc1@kernel.org>
 <Y2JS4bBhPB1qbDi9@nanopsycho>
 <20221102081006.70a81e89@kernel.org>
 <20221102081325.2086edd8@kernel.org>
 <Y2KOnKs0fsDNihaW@nanopsycho>
 <20221102085249.3b64e29f@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221102085249.3b64e29f@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Wed, Nov 02, 2022 at 04:52:49PM CET, kuba@kernel.org wrote:
>On Wed, 2 Nov 2022 16:37:00 +0100 Jiri Pirko wrote:
>> >> Maybe it's time to plumb policies thru to classic netlink, instead of
>> >> creating weird attribute constructs?  
>> >
>> >Not a blocker, FWIW, just pointing out a better alternative.  
>> 
>> Or, even better, move RTnetlink to generic netlink. Really, there is no
>> point to have it as non-generic netlink forever. We moved ethtool there,
>> why not RTnetlink?
>
>As a rewrite?  We could plug in the same callbacks into a genl family
>but the replies / notifications would have different headers depending
>on the socket type which gets hairy, no?

I mean like ethtool, completely side iface, independent, new attrs etc.
We can start with NetdevNetlink for example. Just cover netdev part of
RTNetlink. That is probably most interesting anyway.


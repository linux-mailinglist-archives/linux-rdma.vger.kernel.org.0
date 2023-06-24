Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E360173CA0A
	for <lists+linux-rdma@lfdr.de>; Sat, 24 Jun 2023 11:23:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232775AbjFXJXp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 24 Jun 2023 05:23:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232574AbjFXJXn (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 24 Jun 2023 05:23:43 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 743C219AB
        for <linux-rdma@vger.kernel.org>; Sat, 24 Jun 2023 02:23:40 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-98d8c38549dso197738966b.1
        for <linux-rdma@vger.kernel.org>; Sat, 24 Jun 2023 02:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1687598619; x=1690190619;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EuyyoXYkLcFUjNW6aU0LWhkMHFG4qPaiZWIPRvxeeTA=;
        b=g66y85pUmxbEk8gM1Z1/c1SSekEW4T1k4oAFY2odQs17Fe0i5NQtNAg8YfQ0y5PXDO
         JQ0h5TKyFH8kEJexF4E5uUAYUUTvoLrtDbttalI/TpRRut0MeLBi39qT+qPR9h2crIJ4
         twd4vI/Sgf2PrnmqyK4K7Wfk3B5izATUbxSr/5XJzNoy2H7OMyCEm4o7a+q8aRj8ALE4
         dqMLqsB7Vh2D8EfuzTaNFD6MfGlIax3uCuCFL0a+TPqcfaqOdGNmhNNnmzTkV7GZQG27
         WzW2S7rjCG8vBIjq8J0kwEv7E4teVB6wT4a9BZsQ0gYmst95bLhaIEBSGkJK5s+jxcOj
         U1Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687598619; x=1690190619;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EuyyoXYkLcFUjNW6aU0LWhkMHFG4qPaiZWIPRvxeeTA=;
        b=kuHBXLIy7kZekEXEitNa4J7ZP8B8EPiL44Wq//c13yxjwCYGs/2iihY2YgzNzit1tj
         fUUYveB4AudptnAfkyM+jy2oJSOjvmmqn+5ztPmXARhG5DYnb3E5DmuaW5hD6VKuVYpr
         oHqRO/7ywej/7xpVGYgu0P56bYtkn74DveQ4irE1uDND3NJCRt4EOJfLLvOyINOKVixj
         /+JxkDjdJuzbWQVIz1Gs4o92G7TmNwk5JliVrNcmfT9nBFdmvtDRNqAlcpJXqcBKZY0s
         KsJ3rW1TjJWlFRegr+XvowCRJ6AlTh4/SOV7xdwCMbYdUHUThHGAqCNPu1OB5Ft4Z945
         Hw7g==
X-Gm-Message-State: AC+VfDyLQXA8eE2mDX9Mm331qinQrmQcaHED1lK7sIjlBVPPmoW2Vddo
        qfuIIyjMPWloNaL+A9ls8dBoeQ==
X-Google-Smtp-Source: ACHHUZ7Hm22TLuZ2uNMqorvhvVqmtSRdvFVMVJyZ7P02nHMQr1v41Obhbu8aAZ5ky21fmiU2Y7E37A==
X-Received: by 2002:a17:907:2bc8:b0:98d:758:75ed with SMTP id gv8-20020a1709072bc800b0098d075875edmr6033410ejc.75.1687598618680;
        Sat, 24 Jun 2023 02:23:38 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id q22-20020a17090622d600b009895af2580asm671367eja.36.2023.06.24.02.23.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Jun 2023 02:23:37 -0700 (PDT)
Date:   Sat, 24 Jun 2023 11:23:36 +0200
From:   Jiri Pirko <jiri@resnulli.us>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
        vadfed@meta.com, jonathan.lemon@gmail.com, pabeni@redhat.com,
        corbet@lwn.net, davem@davemloft.net, edumazet@google.com,
        vadfed@fb.com, jesse.brandeburg@intel.com,
        anthony.l.nguyen@intel.com, saeedm@nvidia.com, leon@kernel.org,
        richardcochran@gmail.com, sj@kernel.org, javierm@redhat.com,
        ricardo.canuelo@collabora.com, mst@redhat.com, tzimmermann@suse.de,
        michal.michalik@intel.com, gregkh@linuxfoundation.org,
        jacek.lawrynowicz@linux.intel.com, airlied@redhat.com,
        ogabbay@kernel.org, arnd@arndb.de, nipun.gupta@amd.com,
        axboe@kernel.dk, linux@zary.sk, masahiroy@kernel.org,
        benjamin.tissoires@redhat.com, geert+renesas@glider.be,
        milena.olech@intel.com, kuniyu@amazon.com, liuhangbin@gmail.com,
        hkallweit1@gmail.com, andy.ren@getcruise.com, razor@blackwall.org,
        idosch@nvidia.com, lucien.xin@gmail.com, nicolas.dichtel@6wind.com,
        phil@nwl.cc, claudiajkang@gmail.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        intel-wired-lan@lists.osuosl.org, linux-rdma@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, poros@redhat.com,
        mschmidt@redhat.com, linux-clk@vger.kernel.org,
        vadim.fedorenko@linux.dev
Subject: Re: [RFC PATCH v9 00/10] Create common DPLL configuration API
Message-ID: <ZJa2GEr6frhHQrS0@nanopsycho>
References: <20230623123820.42850-1-arkadiusz.kubalewski@intel.com>
 <ZJW37ynDxJCwHscN@nanopsycho>
 <20230623085336.1a486ca3@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230623085336.1a486ca3@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Fri, Jun 23, 2023 at 05:53:36PM CEST, kuba@kernel.org wrote:
>On Fri, 23 Jun 2023 17:19:11 +0200 Jiri Pirko wrote:
>> I don't understand. The discussion in the RFCv8 thread is still going
>> on. The things I mentioned there are ignored. Like for example:
>> 1) mode_set op removal
>> 2) odd ice dpll locking scheme (either fix or describe why it is ok -
>> 				that's the unfinished discussion)
>> 3) header file bits squash I suggested. Vadim wrote that it sounds
>>    reasonable, yet nothing changed
>> 
>> I thought we are past this. Why I have to point the same issues over and
>> over?
>
>FWIW I'm lost in the previous thread, so for me there's value in
>refreshing the series.
>
>But you're right, at the very least there should be a summary of
>outstanding issues / open items / ongoing discussions in the cover
>letter.

Well I would like to conclude discussion in one thread before sending
the next one. What should I do? Should I start the same discussion
pointing out the same issues in this thread again? This can't work.

Even concluded items are ignored, like 3)

IDK, this is very frustrating for me. I have to double check everything
just in case it was not ignored. I don't understand this, there is no
justification.

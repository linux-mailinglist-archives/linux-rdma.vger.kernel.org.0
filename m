Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FA3773CCD0
	for <lists+linux-rdma@lfdr.de>; Sat, 24 Jun 2023 23:43:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbjFXVnP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 24 Jun 2023 17:43:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjFXVnO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 24 Jun 2023 17:43:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F7E8DD;
        Sat, 24 Jun 2023 14:43:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D04E36093C;
        Sat, 24 Jun 2023 21:43:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E909C433C0;
        Sat, 24 Jun 2023 21:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687642992;
        bh=lmOEecdkRp4pBOR9oOVxNztmp5HIMJkVrx6xS1MQx8k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=AILdp2c5CxOsj6tC0tqBVwvgFwGEWi/HNCqgnUP9ie2N/3J8Q6hT7ivMLWul3XZHr
         K0F527m3/A5wfokBRBq2EoCdMo9FsgZZ4xXrI34JiaXoTZs6r2Tqo0mWGyNuvkT5Hx
         rqBkXq7TJf9KNU0u4uFislfstbrlfbHFz3kgruQ6jVE3iG5BADxR8sM3S+eQaaELaB
         U9QP8K7Retu4ZVuHIWC+4aWzH36dvMxjUeAGjhNXxvzpZGdUy6XFg4nqRO05CBGEs7
         ChgFMA7WUcZdECRkGHISdSMolv/X7dTDd+Jy57O7j1GzG0otI8Oj52RnmkIxn5x8Ut
         UPn4FnOQlZyHg==
Date:   Sat, 24 Jun 2023 14:43:09 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Jiri Pirko <jiri@resnulli.us>
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
Message-ID: <20230624144309.71aa507d@kernel.org>
In-Reply-To: <ZJa2GEr6frhHQrS0@nanopsycho>
References: <20230623123820.42850-1-arkadiusz.kubalewski@intel.com>
        <ZJW37ynDxJCwHscN@nanopsycho>
        <20230623085336.1a486ca3@kernel.org>
        <ZJa2GEr6frhHQrS0@nanopsycho>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, 24 Jun 2023 11:23:36 +0200 Jiri Pirko wrote:
> Well I would like to conclude discussion in one thread before sending
> the next one. What should I do? Should I start the same discussion
> pointing out the same issues in this thread again? This can't work.
> 
> Even concluded items are ignored, like 3)
> 
> IDK, this is very frustrating for me. I have to double check everything
> just in case it was not ignored. I don't understand this, there is no
> justification.

Yes, the open items need to be clearly stated on a new posting.

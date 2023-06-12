Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC2D372D519
	for <lists+linux-rdma@lfdr.de>; Tue, 13 Jun 2023 01:45:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231126AbjFLXpV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 12 Jun 2023 19:45:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234190AbjFLXpU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 12 Jun 2023 19:45:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AF5110F9;
        Mon, 12 Jun 2023 16:45:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 09359617D1;
        Mon, 12 Jun 2023 23:45:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6862DC433EF;
        Mon, 12 Jun 2023 23:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686613518;
        bh=wiSNyZ18E7j0+vGKZGV00souZm1bq4VUlxQ/AgkGk+M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=J/MbfG7MqX/927qmjvcVnKooeZ6fLV4ndi1AMb2SvblEdbUjlOz3OsBYSj7Hb2YxX
         p1UDScovbSf5bMhh7Wj5E9CIrguJ/9jISL1SL83WoQmh0XafXF+1pYkc/JWTCq0QZP
         w8RNro1J+vNs9ODuH5Ry+9ABjZh9vMybvqv3FnW/Xa1DFv4gHlkZUV3ONDL42+45kw
         9NkF5K7GWjvQHRD84IifFKUHQefevWPmINHyeKebUTarV7OZnETKsrrZdIvVFml7YD
         Q5pXXPFTmIdOttGbUj2lZ+nxblghEnDRRXezc++cLqoqTE3lmI61WYh+dktineV29n
         VYg0dlPUojOKg==
Date:   Mon, 12 Jun 2023 16:45:15 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Cc:     jiri@resnulli.us, vadfed@meta.com, jonathan.lemon@gmail.com,
        pabeni@redhat.com, corbet@lwn.net, davem@davemloft.net,
        edumazet@google.com, vadfed@fb.com, jesse.brandeburg@intel.com,
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
Subject: Re: [RFC PATCH v8 03/10] dpll: core: Add DPLL framework base
 functions
Message-ID: <20230612164515.6eacefb1@kernel.org>
In-Reply-To: <20230609121853.3607724-4-arkadiusz.kubalewski@intel.com>
References: <20230609121853.3607724-1-arkadiusz.kubalewski@intel.com>
        <20230609121853.3607724-4-arkadiusz.kubalewski@intel.com>
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

On Fri,  9 Jun 2023 14:18:46 +0200 Arkadiusz Kubalewski wrote:
> +	xa_for_each(xa_pins, i, ref) {
> +		if (ref->pin != pin)
> +			continue;
> +		reg = dpll_pin_registration_find(ref, ops, priv);
> +		if (reg) {
> +			refcount_inc(&ref->refcount);
> +			return 0;
> +		}
> +		ref_exists = true;
> +		break;
> +	}
> +
> +	if (!ref_exists) {
> +		ref = kzalloc(sizeof(*ref), GFP_KERNEL);
> +		if (!ref)
> +			return -ENOMEM;
> +		ref->pin = pin;
> +		INIT_LIST_HEAD(&ref->registration_list);
> +		ret = xa_insert(xa_pins, pin->pin_idx, ref, GFP_KERNEL);
> +		if (ret) {
> +			kfree(ref);
> +			return ret;
> +		}
> +		refcount_set(&ref->refcount, 1);
> +	}
> +
> +	reg = kzalloc(sizeof(*reg), GFP_KERNEL);

Why do we have two structures - ref and reg?

> +	if (!reg) {
> +		if (!ref_exists)
> +			kfree(ref);

ref has already been inserted into xa_pins

> +		return -ENOMEM;

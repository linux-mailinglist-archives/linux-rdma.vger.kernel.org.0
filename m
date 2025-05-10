Return-Path: <linux-rdma+bounces-10241-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3666BAB2137
	for <lists+linux-rdma@lfdr.de>; Sat, 10 May 2025 06:48:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B19034C80A3
	for <lists+linux-rdma@lfdr.de>; Sat, 10 May 2025 04:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E8DE1C7017;
	Sat, 10 May 2025 04:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="w21WE+nS"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19462C2ED
	for <linux-rdma@vger.kernel.org>; Sat, 10 May 2025 04:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746852514; cv=none; b=K1SUuSits+GElrqrGU4PRjpUBD6JWoJ0+KdoBkZb5uItodUCdw9/wi8K1wxsKaVA/cFEOrdljjp53pTevXLON0EgbFuWtI3tvQiaAQLxdvVTQ/57US88rHqu4EU+pFBeGX0EE0JTugJGIQriYWGlSlF13YIp5KR6hvSk2dCKGZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746852514; c=relaxed/simple;
	bh=1NrCr8Y7Yk8nkIQHwduC636NbB+UPP/EE9fpkwgL43s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UJ2OGu9WpunGJtaoRUOzv6CneIW20owWeYjZWtMp2bwUnnEPMearQhq2oAdDAZq/9jcH3WwaTo4ErxDHOxDtC7WceTr8BRrysSHXwcY54vR5B+veC1HDBQH5bt7dl9PV1fja4cuZW4aTOFqTAvBN4PLP4AuusjKwOIHW466cbRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=w21WE+nS; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ac3eb3fdd2eso501928166b.0
        for <linux-rdma@vger.kernel.org>; Fri, 09 May 2025 21:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1746852509; x=1747457309; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=U0ocF90m/d57s9zvLLyjTijFwmKaMiodfKLapvGz4i8=;
        b=w21WE+nShwXJ4KV6PsxMvNvTQ/PLNZRMldTRcvPidFQn9f+qH0losmjfHr8HyuqwFO
         1jncGS2cTM9Ss+/bq/5w3ekwZoJ2YaPWscDYKhdKXXXoALyLB8CedN/aWX7/w0Up9tlm
         w8qt+Ztyr7LN6VeGlddU7HXkjN7G+SB5OU/D+fHFXPq2SuxuJQf3pJloB6/z0I73ZtQb
         vSma+deCb572Je5n8MnP/dY6PyZcCoTf8ru2X5BOJLPq1X0jr/xU8ROlVlKVXv1Y18yw
         QmxE1vpfGsQoe21Fa0skxF4mIPXMKgQil+8YPwvva8CugZHwB7Wbfa39V6mdQ5A1YQ5w
         HMVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746852509; x=1747457309;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U0ocF90m/d57s9zvLLyjTijFwmKaMiodfKLapvGz4i8=;
        b=M2xVmJZpVlncQQaQrtvfYRjK+P1Z54hfCUL16CatMfw28fpHL9UYql7H2MeHV66xWh
         W+gWpGMNftjb16YHAWa4E0ZJ6Q0GloHl4zG4G3v8hKSMNIwKkxBH4rz9+ng75vc+oBUE
         csfjPvyP7Foy+0fFjzd7UOfVZZjkTaWlsx/v3SlkLHpQT0zoSJkj3upeuA1ii+iLqYX/
         IjPB3MBgu2mhbadiuhULqs0No5AuT0i2LRtv3cgy3DTpCQqMny36CL5SxPtShuLapVka
         MtUh1hi5SdR/ksvOWMA4RTUUldCLiWjPRYj8lMfbq1UitS6zIif/ETnzqFs9EQgU6Fj3
         vVIw==
X-Forwarded-Encrypted: i=1; AJvYcCWSvU7hN97mAmyMVrt2OSE06SSWzX/6AaYljOfIEbEQsYize1jO9fSYymVoC78x0RK6py7CfGvHA6Nq@vger.kernel.org
X-Gm-Message-State: AOJu0YwVkjQuzUKsJb5OjUiX9+MkFg20NhRtqAbDMx1NqjbTSbOswUFG
	r6h1i2Pj/nkE1ziBdGlHK+n/jA9NhU/6t93JDEvyPU3AiCtIKHhe6c5qiVYqXdQ=
X-Gm-Gg: ASbGncveTeZxcTwYhQHHn1Ld+xRSOwmdikW7obsPEQWmDpF2Sef8RwkPK75dq6HZILl
	9Kv2elbGi8eOY9aBBmc39ZJkDCoKJOx5ho19bC2w3S6Y1oArTSYe1m3dMbL5Izjeo9vk4yCgjTv
	wrWXxlBLP0SrvqXoQhGHkQSKvmCKjeAwhz8GADBARbHjVIqSPX8sotivqfaYqwusGSYWIsLBLq2
	U+6PipRve2kwwoUpcRmHZSHjzYhr26G5mw+oIplqnMYQB8pqJy73JNwxYIYvAnhuiC6WqI/iXJ1
	7SVf5VNaeX3HVkR35byPs369XuBEtW5MYXsoj5CLqhJQAjSkQB1qoQLSfQB4BI3oSU2Cu5fseDW
	z24o5dHn9jgnMecUAww==
X-Google-Smtp-Source: AGHT+IH4k9HquIX1L6xZv+URbpyHEpEdheEI4sKIxZlStd8mde80HQ5fZ7i2WWD/eBMuhvGJMGwV5w==
X-Received: by 2002:a17:906:794c:b0:ad2:d13:3c4e with SMTP id a640c23a62f3a-ad218e8900fmr621959566b.5.1746852508971;
        Fri, 09 May 2025 21:48:28 -0700 (PDT)
Received: from jiri-mlt.client.nvidia.com ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad23fc53229sm4761966b.48.2025.05.09.21.48.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 21:48:28 -0700 (PDT)
Date: Sat, 10 May 2025 06:48:20 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Cc: donald.hunter@gmail.com, kuba@kernel.org, davem@davemloft.net, 
	edumazet@google.com, pabeni@redhat.com, horms@kernel.org, vadim.fedorenko@linux.dev, 
	anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch, 
	aleksandr.loktionov@intel.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	intel-wired-lan@lists.osuosl.org, linux-rdma@vger.kernel.org, 
	Milena Olech <milena.olech@intel.com>
Subject: Re: [PATCH net-next v2 2/3] dpll: add Reference SYNC get/set
Message-ID: <icbprtryf7dhdwymtuvntfcfvl43b4rbzxukg7romz32cx2vmn@dkgfespynxln>
References: <20250509124651.1227098-1-arkadiusz.kubalewski@intel.com>
 <20250509124651.1227098-3-arkadiusz.kubalewski@intel.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250509124651.1227098-3-arkadiusz.kubalewski@intel.com>

Fri, May 09, 2025 at 02:46:50PM +0200, arkadiusz.kubalewski@intel.com wrote:
>Define function for Reference SYNC pin registration and callback ops to
>set/get current feature state.
>
>Implement netlink handler to fill netlink messages with Reference SYNC
>pin configuration of capable pins (pin-get).
>
>Implement netlink handler to call proper ops and configure Reference SYNC
>pin state (pin-set).
>
>Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
>Reviewed-by: Milena Olech <milena.olech@intel.com>
>Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
>---
>v2:
>- rename sync_pins -> ref_sync_pins within `struct dpll_pin` and add doxygen
>  description of ref_sync_pins,
>- improve commit message.
>---
> drivers/dpll/dpll_core.c    |  27 ++++++
> drivers/dpll/dpll_core.h    |   2 +
> drivers/dpll/dpll_netlink.c | 188 ++++++++++++++++++++++++++++++++----
> include/linux/dpll.h        |  10 ++
> 4 files changed, 209 insertions(+), 18 deletions(-)
>
>diff --git a/drivers/dpll/dpll_core.c b/drivers/dpll/dpll_core.c
>index 20bdc52f63a5..805c7aca58c5 100644
>--- a/drivers/dpll/dpll_core.c
>+++ b/drivers/dpll/dpll_core.c
>@@ -506,6 +506,7 @@ dpll_pin_alloc(u64 clock_id, u32 pin_idx, struct module *module,
> 	refcount_set(&pin->refcount, 1);
> 	xa_init_flags(&pin->dpll_refs, XA_FLAGS_ALLOC);
> 	xa_init_flags(&pin->parent_refs, XA_FLAGS_ALLOC);
>+	xa_init_flags(&pin->ref_sync_pins, XA_FLAGS_ALLOC);
> 	ret = xa_alloc_cyclic(&dpll_pin_xa, &pin->id, pin, xa_limit_32b,
> 			      &dpll_pin_xa_id, GFP_KERNEL);
> 	if (ret < 0)
>@@ -514,6 +515,7 @@ dpll_pin_alloc(u64 clock_id, u32 pin_idx, struct module *module,
> err_xa_alloc:
> 	xa_destroy(&pin->dpll_refs);
> 	xa_destroy(&pin->parent_refs);
>+	xa_destroy(&pin->ref_sync_pins);
> 	dpll_pin_prop_free(&pin->prop);
> err_pin_prop:
> 	kfree(pin);
>@@ -595,6 +597,7 @@ void dpll_pin_put(struct dpll_pin *pin)
> 		xa_erase(&dpll_pin_xa, pin->id);
> 		xa_destroy(&pin->dpll_refs);
> 		xa_destroy(&pin->parent_refs);
>+		xa_destroy(&pin->ref_sync_pins);
> 		dpll_pin_prop_free(&pin->prop);
> 		kfree_rcu(pin, rcu);
> 	}
>@@ -783,6 +786,30 @@ void dpll_pin_on_pin_unregister(struct dpll_pin *parent, struct dpll_pin *pin,
> }
> EXPORT_SYMBOL_GPL(dpll_pin_on_pin_unregister);
> 
>+/**
>+ * dpll_pin_ref_sync_pair_add - create a reference sync signal pin pair
>+ * @base: pin which produces the base frequency
>+ * @sync: pin which produces the sync signal
>+ *
>+ * Once pins are paired, the user-space configuration of reference sync pair
>+ * is possible.
>+ * Context: Acquires a lock (dpll_lock)
>+ * Return:
>+ * * 0 on success
>+ * * negative - error value
>+ */
>+int dpll_pin_ref_sync_pair_add(struct dpll_pin *base, struct dpll_pin *sync)
>+{
>+	int ret;
>+
>+	mutex_lock(&dpll_lock);
>+	ret = xa_insert(&base->ref_sync_pins, sync->pin_idx, sync, GFP_KERNEL);
>+	mutex_unlock(&dpll_lock);
>+
>+	return ret;
>+}
>+EXPORT_SYMBOL_GPL(dpll_pin_ref_sync_pair_add);
>+
> static struct dpll_device_registration *
> dpll_device_registration_first(struct dpll_device *dpll)
> {
>diff --git a/drivers/dpll/dpll_core.h b/drivers/dpll/dpll_core.h
>index 2b6d8ef1cdf3..d0b2b995fd62 100644
>--- a/drivers/dpll/dpll_core.h
>+++ b/drivers/dpll/dpll_core.h
>@@ -44,6 +44,7 @@ struct dpll_device {
>  * @module:		module of creator
>  * @dpll_refs:		hold referencees to dplls pin was registered with
>  * @parent_refs:	hold references to parent pins pin was registered with
>+ * @ref_sync_pins	hold references to pins for Reference SYNC feature
>  * @prop:		pin properties copied from the registerer
>  * @rclk_dev_name:	holds name of device when pin can recover clock from it
>  * @refcount:		refcount
>@@ -56,6 +57,7 @@ struct dpll_pin {
> 	struct module *module;
> 	struct xarray dpll_refs;
> 	struct xarray parent_refs;
>+	struct xarray ref_sync_pins;
> 	struct dpll_pin_properties prop;
> 	refcount_t refcount;
> 	struct rcu_head rcu;
>diff --git a/drivers/dpll/dpll_netlink.c b/drivers/dpll/dpll_netlink.c
>index c130f87147fa..7a3db0984b1e 100644
>--- a/drivers/dpll/dpll_netlink.c
>+++ b/drivers/dpll/dpll_netlink.c
>@@ -48,6 +48,24 @@ dpll_msg_add_dev_parent_handle(struct sk_buff *msg, u32 id)
> 	return 0;
> }
> 
>+static bool dpll_pin_available(struct dpll_pin *pin)
>+{
>+	struct dpll_pin_ref *par_ref;
>+	unsigned long i;
>+
>+	if (!xa_get_mark(&dpll_pin_xa, pin->id, DPLL_REGISTERED))
>+		return false;
>+	xa_for_each(&pin->parent_refs, i, par_ref)
>+		if (xa_get_mark(&dpll_pin_xa, par_ref->pin->id,
>+				DPLL_REGISTERED))
>+			return true;
>+	xa_for_each(&pin->dpll_refs, i, par_ref)
>+		if (xa_get_mark(&dpll_device_xa, par_ref->dpll->id,
>+				DPLL_REGISTERED))
>+			return true;
>+	return false;
>+}
>+
> /**
>  * dpll_msg_add_pin_handle - attach pin handle attribute to a given message
>  * @msg: pointer to sk_buff message to attach a pin handle
>@@ -408,6 +426,47 @@ dpll_msg_add_pin_esync(struct sk_buff *msg, struct dpll_pin *pin,
> 	return -EMSGSIZE;
> }
> 
>+static int
>+dpll_msg_add_pin_ref_sync(struct sk_buff *msg, struct dpll_pin *pin,
>+			  struct dpll_pin_ref *ref,
>+			  struct netlink_ext_ack *extack)
>+{
>+	const struct dpll_pin_ops *ops = dpll_pin_ops(ref);
>+	struct dpll_device *dpll = ref->dpll;
>+	enum dpll_pin_state state;
>+	void *pin_priv, *sp_priv;
>+	struct dpll_pin *sp;
>+	struct nlattr *nest;
>+	unsigned long index;
>+	int ret;
>+
>+	pin_priv = dpll_pin_on_dpll_priv(dpll, pin);
>+	xa_for_each(&pin->ref_sync_pins, index, sp) {
>+		if (!dpll_pin_available(sp))
>+			continue;
>+		sp_priv = dpll_pin_on_dpll_priv(dpll, sp);
>+		if (WARN_ON(!ops->ref_sync_get))
>+			return -EOPNOTSUPP;
>+		ret = ops->ref_sync_get(pin, pin_priv, sp, sp_priv,
>+					&state, extack);
>+		if (ret)
>+			return ret;
>+		nest = nla_nest_start(msg, DPLL_A_PIN_REFERENCE_SYNC);
>+		if (!nest)
>+			return -EMSGSIZE;
>+		if (nla_put_s32(msg, DPLL_A_PIN_ID, sp->id))
>+			goto nest_cancel;
>+		if (nla_put_s32(msg, DPLL_A_PIN_STATE, state))
>+			goto nest_cancel;
>+		nla_nest_end(msg, nest);
>+	}
>+	return 0;
>+
>+nest_cancel:
>+	nla_nest_cancel(msg, nest);
>+	return -EMSGSIZE;
>+}
>+
> static bool dpll_pin_is_freq_supported(struct dpll_pin *pin, u32 freq)
> {
> 	int fs;
>@@ -550,6 +609,10 @@ dpll_cmd_pin_get_one(struct sk_buff *msg, struct dpll_pin *pin,
> 	if (ret)
> 		return ret;
> 	ret = dpll_msg_add_pin_esync(msg, pin, ref, extack);
>+	if (ret)
>+		return ret;
>+	if (!xa_empty(&pin->ref_sync_pins))
>+		ret = dpll_msg_add_pin_ref_sync(msg, pin, ref, extack);
> 	if (ret)
> 		return ret;
> 	if (xa_empty(&pin->parent_refs))
>@@ -642,24 +705,6 @@ __dpll_device_change_ntf(struct dpll_device *dpll)
> 	return dpll_device_event_send(DPLL_CMD_DEVICE_CHANGE_NTF, dpll);
> }
> 
>-static bool dpll_pin_available(struct dpll_pin *pin)
>-{
>-	struct dpll_pin_ref *par_ref;
>-	unsigned long i;
>-
>-	if (!xa_get_mark(&dpll_pin_xa, pin->id, DPLL_REGISTERED))
>-		return false;
>-	xa_for_each(&pin->parent_refs, i, par_ref)
>-		if (xa_get_mark(&dpll_pin_xa, par_ref->pin->id,
>-				DPLL_REGISTERED))
>-			return true;
>-	xa_for_each(&pin->dpll_refs, i, par_ref)
>-		if (xa_get_mark(&dpll_device_xa, par_ref->dpll->id,
>-				DPLL_REGISTERED))
>-			return true;
>-	return false;
>-}
>-
> /**
>  * dpll_device_change_ntf - notify that the dpll device has been changed
>  * @dpll: registered dpll pointer
>@@ -887,6 +932,108 @@ dpll_pin_esync_set(struct dpll_pin *pin, struct nlattr *a,
> 	return ret;
> }
> 
>+static int
>+dpll_pin_ref_sync_state_set(struct dpll_pin *pin, unsigned long sync_pin_idx,
>+			    const enum dpll_pin_state state,
>+			    struct netlink_ext_ack *extack)
>+
>+{
>+	struct dpll_pin_ref *ref, *failed;
>+	const struct dpll_pin_ops *ops;
>+	enum dpll_pin_state old_state;
>+	struct dpll_pin *sync_pin;
>+	struct dpll_device *dpll;
>+	unsigned long i;
>+	int ret;
>+
>+	if (state != DPLL_PIN_STATE_CONNECTED &&
>+	    state != DPLL_PIN_STATE_DISCONNECTED)
>+		return -EINVAL;
>+	sync_pin = xa_find(&pin->ref_sync_pins, &sync_pin_idx, ULONG_MAX,
>+			   XA_PRESENT);
>+	if (!sync_pin) {
>+		NL_SET_ERR_MSG(extack, "reference sync pin not found");
>+		return -EINVAL;
>+	}
>+	if (!dpll_pin_available(sync_pin)) {
>+		NL_SET_ERR_MSG(extack, "reference sync pin not available");
>+		return -EINVAL;
>+	}
>+	ref = dpll_xa_ref_dpll_first(&pin->dpll_refs);
>+	ASSERT_NOT_NULL(ref);
>+	ops = dpll_pin_ops(ref);
>+	if (!ops->ref_sync_set || !ops->ref_sync_get) {
>+		NL_SET_ERR_MSG(extack, "reference sync not supported by this pin");
>+		return -EOPNOTSUPP;
>+	}
>+	dpll = ref->dpll;
>+	ret = ops->ref_sync_get(pin, dpll_pin_on_dpll_priv(dpll, pin), sync_pin,
>+				dpll_pin_on_dpll_priv(dpll, sync_pin),
>+				&old_state, extack);
>+	if (ret) {
>+		NL_SET_ERR_MSG(extack, "unable to get old reference sync state");
>+		return -EINVAL;

Propagate ret. Not sure why you ignored my comment about this.



>+	}
>+	if (state == old_state)
>+		return 0;
>+	xa_for_each(&pin->dpll_refs, i, ref) {
>+		ops = dpll_pin_ops(ref);
>+		dpll = ref->dpll;
>+		ret = ops->ref_sync_set(pin, dpll_pin_on_dpll_priv(dpll, pin),
>+					sync_pin,
>+					dpll_pin_on_dpll_priv(dpll, sync_pin),
>+					state, extack);
>+		if (ret) {
>+			failed = ref;
>+			NL_SET_ERR_MSG_FMT(extack, "reference sync set failed for dpll_id:%u",
>+					   dpll->id);

Why you print id? User knows what he works on, don't he?



>+			goto rollback;
>+		}
>+	}
>+	__dpll_pin_change_ntf(pin);
>+
>+	return 0;
>+
>+rollback:
>+	xa_for_each(&pin->dpll_refs, i, ref) {
>+		if (ref == failed)
>+			break;
>+		ops = dpll_pin_ops(ref);
>+		dpll = ref->dpll;
>+		if (ops->ref_sync_set(pin, dpll_pin_on_dpll_priv(dpll, pin),
>+				      sync_pin,
>+				      dpll_pin_on_dpll_priv(dpll, sync_pin),
>+				      old_state, extack))
>+			NL_SET_ERR_MSG(extack, "set reference sync rollback failed");
>+	}
>+	return ret;
>+}
>+
>+static int
>+dpll_pin_ref_sync_set(struct dpll_pin *pin, struct nlattr *nest,
>+		      struct netlink_ext_ack *extack)
>+{
>+	struct nlattr *tb[DPLL_A_PIN_MAX + 1];
>+	enum dpll_pin_state state;
>+	u32 sync_pin_id;
>+
>+	nla_parse_nested(tb, DPLL_A_PIN_MAX, nest,
>+			 dpll_reference_sync_nl_policy, extack);
>+	if (!tb[DPLL_A_PIN_ID]) {
>+		NL_SET_ERR_MSG(extack, "sync pin id expected");
>+		return -EINVAL;
>+	}
>+	sync_pin_id = nla_get_u32(tb[DPLL_A_PIN_ID]);
>+
>+	if (!tb[DPLL_A_PIN_STATE]) {
>+		NL_SET_ERR_MSG(extack, "sync pin state expected");
>+		return -EINVAL;
>+	}
>+	state = nla_get_u32(tb[DPLL_A_PIN_STATE]);
>+
>+	return dpll_pin_ref_sync_state_set(pin, sync_pin_id, state, extack);
>+}
>+
> static int
> dpll_pin_on_pin_state_set(struct dpll_pin *pin, u32 parent_idx,
> 			  enum dpll_pin_state state,
>@@ -1193,6 +1340,11 @@ dpll_pin_set_from_nlattr(struct dpll_pin *pin, struct genl_info *info)
> 			if (ret)
> 				return ret;
> 			break;
>+		case DPLL_A_PIN_REFERENCE_SYNC:
>+			ret = dpll_pin_ref_sync_set(pin, a, info->extack);
>+			if (ret)
>+				return ret;
>+			break;
> 		}
> 	}
> 
>diff --git a/include/linux/dpll.h b/include/linux/dpll.h
>index 5e4f9ab1cf75..f1f1fdda67fe 100644
>--- a/include/linux/dpll.h
>+++ b/include/linux/dpll.h
>@@ -95,6 +95,14 @@ struct dpll_pin_ops {
> 			 const struct dpll_device *dpll, void *dpll_priv,
> 			 struct dpll_pin_esync *esync,
> 			 struct netlink_ext_ack *extack);
>+	int (*ref_sync_set)(const struct dpll_pin *pin, void *pin_priv,
>+			    const struct dpll_pin *ref_pin, void *ref_pin_priv,
>+			    const enum dpll_pin_state state,
>+			    struct netlink_ext_ack *extack);
>+	int (*ref_sync_get)(const struct dpll_pin *pin, void *pin_priv,
>+			    const struct dpll_pin *ref_pin, void *ref_pin_priv,
>+			    enum dpll_pin_state *state,
>+			    struct netlink_ext_ack *extack);
> };
> 
> struct dpll_pin_frequency {
>@@ -194,6 +202,8 @@ int dpll_pin_on_pin_register(struct dpll_pin *parent, struct dpll_pin *pin,
> void dpll_pin_on_pin_unregister(struct dpll_pin *parent, struct dpll_pin *pin,
> 				const struct dpll_pin_ops *ops, void *priv);
> 
>+int dpll_pin_ref_sync_pair_add(struct dpll_pin *base, struct dpll_pin *sync);
>+
> int dpll_device_change_ntf(struct dpll_device *dpll);
> 
> int dpll_pin_change_ntf(struct dpll_pin *pin);
>-- 
>2.38.1
>


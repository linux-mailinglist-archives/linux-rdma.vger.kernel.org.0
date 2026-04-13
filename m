Return-Path: <linux-rdma+bounces-19287-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oANnBOHc3GlwXgkAu9opvQ
	(envelope-from <linux-rdma+bounces-19287-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Apr 2026 14:09:05 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C0DE63EBB76
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Apr 2026 14:09:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 16365301300F
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Apr 2026 12:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2B3A3C3C12;
	Mon, 13 Apr 2026 12:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="k4ACmIf5"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 037383C3457
	for <linux-rdma@vger.kernel.org>; Mon, 13 Apr 2026 12:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776082137; cv=none; b=tA6X5eEyvbg5nJHSwPt7T5lcBYf4PVEjbj1ntVvRJssYkX4Jhx/D+NWUUoUPwR+8ymWRh35SDFC/qIm3E0NEhUdVmxuUNyMomceipVo9rf8NlKGMbKN37WGTEosebR3svJ6+UBgfOlKIJRQAs21Uwe/2DXFeAZ0LmhZ/UcRXuK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776082137; c=relaxed/simple;
	bh=b2oAs+7vRWLLh/ZhqKcI6Wf3Rh+33ekKWwGwtI3FYVM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BgyJyc/ov/2YYpnp7B6n+QwBxm83rzh01fWxWliEm6uVnvn1XsvHnYKDJOMDbbYHNNYJl/JDR3gcSMFOLGV8VAKhxjhh3pZZqhbqv2rkK5z8DSTDCKoq/Z9+fLB8yuUnrFIMLRDV3uFYJz96rwDj6QyJeB16GLgOI4iFDk37IVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=k4ACmIf5; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-488a8ca4aadso50900025e9.3
        for <linux-rdma@vger.kernel.org>; Mon, 13 Apr 2026 05:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1776082131; x=1776686931; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IRwudnmggZ/XUXjz8Dn4rqFQM8+32hzeX1Hgry14NgQ=;
        b=k4ACmIf5ffGmWi25liCp2Y6LH8mtiV1g5BEtmb7iIfZPGvdtIpx0Mvk2NkOztVPAPG
         2r5I7/yTDgAm/f+bhugfjKSDmWyzUYtCUbeSFRa4cNOv6VjHZzyJJ5SOuvbsyGFit7ns
         Ox9oZ3dD3kIyW09hT3vah6mnnlo2OPNmpWfMuFiISGdCLx+OIam2Tkq/Kyq9gENQ3M/n
         vy+8TDGe5MPyTwLCydwX9rryjOhsmN9ii1O+HHUgvfo/sUuHkqLj8f56u7L58E9ZJ1Ey
         EFkt3DX/PFB9EPKS04nKU7yQVLxEuHKSKUqQsOK6sn86Hiie/LVXc3f2PJe3gID9CguH
         7Zcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776082131; x=1776686931;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IRwudnmggZ/XUXjz8Dn4rqFQM8+32hzeX1Hgry14NgQ=;
        b=mJtYCMzzmx83g22XqN/2jd6IqrcMj+ntkglUbKzvpi81gBLu1Ys/V/ys1zE3IhbW0m
         jS1rZ/QiTE7kZ7lUaak91Rf9szkR2THC3GfzyqL7W6Izg0PGVJ7yTXfFVxQNS0ISKbzg
         AxzJEZirrn5hrbFlwaWyQBk537L+ejPppfU36IB15mS6NzrIzQgkpZMRigIO+qwoFMxB
         wBruc8djX4p8xpQTBTtcIr6fzuobNZ5L3QXPwOQKuCP0aTDc7+TCYkQY4yBUoIClq0ar
         Dm9ZCNgR5fiQO5dcbECR/SZFXtUHsf4rOLVztdyiUIGZP4mqNkG7z6yG1H+ptPyZuLWz
         2ACg==
X-Forwarded-Encrypted: i=1; AFNElJ8VHAxje8vjJZl3B66qCSumohHS17Y++wyJr3I5pdI1tGH+oyk99DzJFNXHbPrO4PZtxZaXgjvHRU6F@vger.kernel.org
X-Gm-Message-State: AOJu0YxEPur/0nz3tBk5CVNDEQtZUAcbJq5K0onIeuzbqzA9DSUhgCCU
	x5bAPXzoK9DXi7xPTMj6RZbOTbp2Ip3wp0Ev7vMk+ylK7kvVA2C/ZnU3D2RHO5EtvtQ=
X-Gm-Gg: AeBDieu5HAmSoI65tI+bbyumGwwsTVKFMlSWaHcjxtn/BHggrdrwKPCzYzQwNohtWmn
	OVGcgqruTsQ5W0ABkhMoKv2G4UYGux/+iWlWM5BNxinPu75bwmv/PZv70RMTodt54oigjUAoZNE
	aiPzhF+4oLpecz3GCXH3jr4l4XGeFBPAIDi8h08io70OUjy4Md2lEdrNNILMLGV3vqYlpt59D/R
	eY8CFinXZRkMhrYNi7S3NuxxAbE0S6x8auXvmE2Uhieoe0WXJwDfPbOMm04fHmP2Akj0t9CSoJe
	hwDF4zPAOoTEqxEwl5CidXtV/IKeZTQEDOrMOkW1iXjV/er3HSOmQA2b/4bEBgzcfdgzsKdsv9x
	v58FjmY7lNPISpaL/gP+wnTnqlVzP3OWbqE4CA/ohqzTQAl0/KBI1ZX1VlLDk4Dz2zgWguKdtnX
	WJEB3FdNlzpgA31VFDzzeWxM2IMerFoLE=
X-Received: by 2002:a05:600c:3149:b0:488:ab26:8fe0 with SMTP id 5b1f17b1804b1-488d68432f2mr183678385e9.15.1776082131150;
        Mon, 13 Apr 2026 05:08:51 -0700 (PDT)
Received: from FV6GYCPJ69 ([208.127.45.21])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d68479b2sm92668315e9.25.2026.04.13.05.08.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 05:08:50 -0700 (PDT)
Date: Mon, 13 Apr 2026 14:08:47 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-rdma@vger.kernel.org, sgoutham@marvell.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, donald.hunter@gmail.com, 
	horms@kernel.org, chuck.lever@oracle.com, matttbe@kernel.org, cjubran@nvidia.com, 
	saeedm@nvidia.com, leon@kernel.org, tariqt@nvidia.com, mbloch@nvidia.com, 
	dtatulea@nvidia.com
Subject: Re: [PATCH v11 net-next 4/7] devlink: Implement devlink param multi
 attribute nested data values
Message-ID: <3pk4hkzgwy3a55zveapgmk23bsevru55xv75vhkzbpmzkfofcx@rlnkrvynofig>
References: <20260409025055.1664053-1-rkannoth@marvell.com>
 <20260409025055.1664053-5-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260409025055.1664053-5-rkannoth@marvell.com>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19287-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_CC(0.00)[vger.kernel.org,marvell.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,oracle.com,nvidia.com];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[resnulli-us.20251104.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:email]
X-Rspamd-Queue-Id: C0DE63EBB76
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thu, Apr 09, 2026 at 04:50:52AM +0200, rkannoth@marvell.com wrote:
>From: Saeed Mahameed <saeedm@nvidia.com>

[...]


>diff --git a/net/devlink/param.c b/net/devlink/param.c
>index 4595fffbd825..8c9165797b32 100644
>--- a/net/devlink/param.c
>+++ b/net/devlink/param.c
>@@ -252,6 +252,14 @@ devlink_nl_param_value_put(struct sk_buff *msg, enum devlink_param_type type,
> 				return -EMSGSIZE;
> 		}
> 		break;
>+	case DEVLINK_PARAM_TYPE_U64_ARRAY:
>+		if (val->u64arr.size > __DEVLINK_PARAM_MAX_ARRAY_SIZE)

From UAPI perspective, what's the motivation for such limitation? I
don't think we need it. Whatever kernel/user fits into skb is okay, no?




>+			return -EMSGSIZE;
>+
>+		for (int i = 0; i < val->u64arr.size; i++)
>+			if (nla_put_uint(msg, nla_type, val->u64arr.val[i]))
>+				return -EMSGSIZE;
>+		break;
> 	}
> 	return 0;
> }

[...]


Return-Path: <linux-rdma+bounces-14996-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AF6ECBDF5E
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Dec 2025 14:13:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7674C302858D
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Dec 2025 13:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B80642D63E5;
	Mon, 15 Dec 2025 13:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="IsBVPjvz"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E8B72BEC23
	for <linux-rdma@vger.kernel.org>; Mon, 15 Dec 2025 13:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765804119; cv=none; b=e5/2eKEGBnx1BxbLMsrzk8KD8viNds7mlwbDwNOVvHmdg/J5tEn31XmtcpLaXkItAoBUamzYK19OD92LzXJ04tqPBizLOuv+N3huMvJQPd/II2oCvoH36Eejm6ZmxkGv3UvGM/w6paT8U6qX9Ls33s80/+MwEq/E9O/0OYK4hzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765804119; c=relaxed/simple;
	bh=ZYmTRTKIVD+6TduLcshjIka+qce51+uR2+bkkTZBuWo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UePmirpt6X8rKzPyMx23cddw+i3CgYR6OHpmgFTP0QKWF3RB9UD5n5sAwwPyMf83nDBjM6AcyMerj6l5qYFJcl8dDPCWqr7cDel8rgTfjHaOyPFo6TltjR2ZzWTSSqy2ChlBnJYKXOYS3jSBlpZwhezx2SX0E5SSBQox54kbgDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=IsBVPjvz; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4779cb0a33fso41985835e9.0
        for <linux-rdma@vger.kernel.org>; Mon, 15 Dec 2025 05:08:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1765804116; x=1766408916; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cGF6UGlZTvH/e7EAbUoFjWHETVQLZMdqI3gLEZl8+UE=;
        b=IsBVPjvz+stZ959QVielmyjWE9BV9a3+CCVbQSc9u0pf1gIP2yEXS9ut9zsCDknVov
         PvS2zo1ruCW4G+D2wdWY4lwn+egxlDn1P8a3GD4HaV8k2WKkF8BjfwsMwx1yJBzUIRdL
         Qm0Dk7rYyYJMYAwzPdclqLhjmDz0Yha/dTvNHu8afS2mloGh1osRM+Rp+y/Xj85HgXps
         GXyLzMegXFIKQbOSn+neeWcHk2xl4lKYuZq7zBPgugM8HGi0Bkuhpop1n93pEnjOti+z
         imcWudYWvqcbHosvX7T/gsvDYLKo3k7PGvcfjBBxb1ugJzzfVxtGNRf/pfdj6Oq2y7G0
         tetQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765804116; x=1766408916;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cGF6UGlZTvH/e7EAbUoFjWHETVQLZMdqI3gLEZl8+UE=;
        b=aasCnJcsgGt3fHCVLVPUUGNocyeCAZ3w3FdT4c7DhAEGub+qgjgc3HXCEYGjHF0vyr
         Zufx2YJLN2Al892jRm+UCX9Ip2+tIIggh9NJMgRk3zTDeX8hafXWLWHgvSOs1oh1zlAr
         i8melvUhKR561qiyY8o4208ca6wornAPgFg6Z10InCAljTIadpllhLLBXcA6VAqyX8IK
         ZzP52AQHv4ydOmCFTkHYOjP/BdnLdq+syqgVREMPwmxY5ljz3KYs8dImB4htFptbYX3d
         qpU6tgWpxhBdVFK+QhJ61bm6AhaFASi0hWBPoZytQtKCeQHU+hCRnAMEeFfOJ0g+ZQXF
         1NXA==
X-Forwarded-Encrypted: i=1; AJvYcCXOEE1QrYvBF0/5hS6OiKHJRLoReRee0pUbrRqRwcuaS7GgO0lSd/JmcDl4ATxT5NiDPYis4H7rOYf7@vger.kernel.org
X-Gm-Message-State: AOJu0YwD1N+z4HrGBCkSgUpbnIye3A+zcQc22KQSYBbuRp/Sm867/0xq
	NVW5jqeEz4V2/5mxLqNNKO+Fighy1sptflfOuLXp/f3qTFGsd3q5ClfM1PESJUzRWSg=
X-Gm-Gg: AY/fxX4n+G6llDbszrb8F3qYeb78beeU0imqgjFZ3xXSmvsZ8TAtoWOtUbHx+S61UHW
	HHfqtUmsDEfxr49he12P1/VgLBB/lQHWBwJafiHa98s5UjrG7UPh4/IGvktuxNlDZwYedCOJvu3
	Bo5i7p5JCZnYKcFQotFYWXENeSDu9AzgNyQW6MI5aKBIMwgs5o/qWf7p5oHTCpluS20slvU5ckG
	XCYx5FZ2xE6jPItxPO+OMcO8s/vZIZURxYwVIqJTx046hbgEId4J/S1ENbpTY9f/z+qmaiMvmAk
	PFNu5bDCur+J62QCGngBENUvaMpgKwMao0fSxSvc6Rt2NphhHcsEBua459v6rHqx8MFVMH+h11t
	9faHAtHJ9cROdAYK2hnBSnYm2WtOi5ZUihNoMncXSuFph29XZShmxaLLofxILz98oED64mvGoAb
	S/nwTqoXQxh0gT73aNOurtTkdnP9XiTERdgg==
X-Google-Smtp-Source: AGHT+IGDeAHVk3bjmiKEh4J5iHFH7+EdX4092IVfO054I0rigKsg6ZDX9O2Htj98oWT0RTZ7eaXYhQ==
X-Received: by 2002:a05:6000:4285:b0:429:b8e2:1064 with SMTP id ffacd0b85a97d-42fb490f769mr11817646f8f.47.1765804115472;
        Mon, 15 Dec 2025 05:08:35 -0800 (PST)
Received: from FV6GYCPJ69 ([140.209.217.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-430f268d459sm13887608f8f.32.2025.12.15.05.08.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 05:08:34 -0800 (PST)
Date: Mon, 15 Dec 2025 14:08:31 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Ivan Vecera <ivecera@redhat.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Vadim Fedorenko <vadim.fedorenko@linux.dev>, Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>, 
	Grzegorz Nitka <grzegorz.nitka@intel.com>, Petr Oros <poros@redhat.com>, 
	Michal Schmidt <mschmidt@redhat.com>, Prathosh Satish <Prathosh.Satish@microchip.com>, 
	Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, 
	Richard Cochran <richardcochran@gmail.com>, Jonathan Lemon <jonathan.lemon@gmail.com>, 
	Simon Horman <horms@kernel.org>, Alexander Lobakin <aleksander.lobakin@intel.com>, 
	Willem de Bruijn <willemb@google.com>, Stefan Wahren <wahrenst@gmx.net>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, intel-wired-lan@lists.osuosl.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH RFC net-next 02/13] dpll: Allow registering pin with
 firmware node
Message-ID: <tawd6udewifjeoymxkfkapxgcgfviixb4zgcjnplycigk5ffws@rdymwt2hknsl>
References: <20251211194756.234043-1-ivecera@redhat.com>
 <20251211194756.234043-3-ivecera@redhat.com>
 <ahyyksqki6bas5rqngd735k4fmoeaj7l2a7lazm43ky3lj6ero@567g2ijcpekp>
 <3E2869EC-61B3-40DA-98E2-CD9543424468@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E2869EC-61B3-40DA-98E2-CD9543424468@redhat.com>

Sun, Dec 14, 2025 at 08:35:01PM +0100, ivecera@redhat.com wrote:
>
>
>On December 12, 2025 12:25:12 PM GMT+01:00, Jiri Pirko <jiri@resnulli.us> wrote:
>>Thu, Dec 11, 2025 at 08:47:45PM +0100, ivecera@redhat.com wrote:
>>
>>[..]
>>
>>>@@ -559,7 +563,8 @@ EXPORT_SYMBOL(dpll_netdev_pin_clear);
>>>  */
>>> struct dpll_pin *
>>> dpll_pin_get(u64 clock_id, u32 pin_idx, struct module *module,
>>>-	     const struct dpll_pin_properties *prop)
>>>+	     const struct dpll_pin_properties *prop,
>>>+	     struct fwnode_handle *fwnode)
>>> {
>>> 	struct dpll_pin *pos, *ret = NULL;
>>> 	unsigned long i;
>>>@@ -568,14 +573,15 @@ dpll_pin_get(u64 clock_id, u32 pin_idx, struct module *module,
>>> 	xa_for_each(&dpll_pin_xa, i, pos) {
>>> 		if (pos->clock_id == clock_id &&
>>> 		    pos->pin_idx == pin_idx &&
>>>-		    pos->module == module) {
>>>+		    pos->module == module &&
>>>+		    pos->fwnode == fwnode) {
>>
>>Is fwnode part of the key? Doesn't look to me like that. Then you can
>>have a simple helper to set fwnode on struct dpll_pin *, and leave
>>dpll_pin_get() out of this, no?
>
>IMHO yes, because particular fwnode identifies exact dpll pin, so
>I think it should be a part of the key.

The key items serve for userspace identification purposes as well. For
that, fwnode is non-sense.
fwnode identifies exact pin, that is nice. But is it the only
differentiator among other key items? I don't expect so.

>


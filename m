Return-Path: <linux-rdma+bounces-10185-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5243AB0A52
	for <lists+linux-rdma@lfdr.de>; Fri,  9 May 2025 08:12:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 903BC4C4838
	for <lists+linux-rdma@lfdr.de>; Fri,  9 May 2025 06:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A03B026A1C7;
	Fri,  9 May 2025 06:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="eIu8tQKQ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1AF726A1A4
	for <linux-rdma@vger.kernel.org>; Fri,  9 May 2025 06:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746771132; cv=none; b=U5A2dUh/0tIrIt3mx2vHyowy0L2K1smPZg/fYn2jqfyHrp1u3bgGoRZPQD/ZuDeqYoa2ZA8SU0Ueg8I8h1oFcmbAb4slnvtCe2Gg+LT+1AJZVDpTAXxABwx0MbZbNVYLuUCsA6IU9Ap1Yf7dSYB6oOt1ushHw7Q6tFMnv8uNX4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746771132; c=relaxed/simple;
	bh=SgmwctySlGbZE8Y7ECt5BO41p9Wa+WOMQmklCfcn83w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VNb9zQG/c/UGE1/UCU+cMkoFMBC31E+WhyVKZuotgrDcDsBMqJz9KxtiobxnZIuvciixltQJxCF3aIrCGbQl6V4MyLtf4xF0nhqRMdS+/1/n7N0x0Yd8fOKvb8JS9JjnVA/+D07wSSR6qRHnSmNfAT62Y5YZtja2pZrehvv1BAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=eIu8tQKQ; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5fcaff7274bso145650a12.2
        for <linux-rdma@vger.kernel.org>; Thu, 08 May 2025 23:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1746771128; x=1747375928; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JsqZgIgkSuMcTrxJQRDgcEGPZOgCfhwflJ33fpoq6jw=;
        b=eIu8tQKQDIDwxtYY3zuBoyq8Y7VVZ87Z+VNUmaQDOeEZGgt5M6Fd1ho8251/+t2Rmh
         Rj+iM8yioRdBwr1WNrWrCyo+skh4ZPt9FV7XnJdTJIBd8iB1Y1iiv2ghX4MGEZC+BiBF
         QvI/xLqHTc4q9rjkDK1WjbnSvRUGCwOXlKrEhCBhezYCHoijI+g2SRQ6hrTU2T3je1lm
         Ap/3CReNGXMzHi2f6CexEFsMYxnxHZWl+R4qGwOepXx3jcx5Bm09gt5ICoPmZwaJHqNE
         OXQs5xLgZAKjLoeLDbaK9mWZDx5krAAqIsq3ybhFErVOM0FU0M4oAg+W5FjYZ6tfKt1Q
         x94w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746771128; x=1747375928;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JsqZgIgkSuMcTrxJQRDgcEGPZOgCfhwflJ33fpoq6jw=;
        b=brwwMo2a3bpK9txaOkSCzqR35NpCSj0NX6DI1ylKab3ryRJzGQgHfZ8ekZwujTiwr3
         R9tlvZ4wIwI8pg+zcv9RYb7uTcyn1I4b+aeBW/5N6mDAjcLeyFKKyTV2mvZT+kr1qrUA
         JZxnXXcdKuL1Vaez3wfQGOQbkE0/qwzC9nVZXewDiC2mjiN8LGBYxKHgCHRDHBdApMuI
         HgJiOO7ixcGT7jODdYoRfw53/QsWwgG66Tk5oB59vElnv4lICUkoTxLnJn5YDjixzDmI
         KBqf9FK4LdEHQlhthsmwvG3JGPDnHxrqoNliEVdSTArCl9soOGyfj9tNxhEkyi92tAW1
         Y+RA==
X-Forwarded-Encrypted: i=1; AJvYcCWyPrhk/u1AWceZNdutmHCmDVxTDTasBFxuMnVTQxenrCQpJ2mwj1kSMYcLdcptyga7r3XCpj+++Svs@vger.kernel.org
X-Gm-Message-State: AOJu0YyJVCd+N4aCTJESgl3LXy164LvB+juz3VRFZ8nEUP0RlPBJx5OG
	+WPTuTHP0XtL8v7ronLzY+tWrEZSAK+uQ5YR1FPOVCfS3/CkSM3Y840rLBltRbA=
X-Gm-Gg: ASbGncuJp4Rj08qEThPjz9DCVPJOjNvyoFdQD02yi9PovlknIgD3tUGBv3tROysy26z
	jYMK6j3pHDrcKb764pceeg8ZYfkWeTO/dEsrzFOSW7DVUReZyL6V3zupu+0tIJwS5E35HTRU2Lb
	LNVG5GRimI8nMagvB3gvtkReLdt+j3X4k8wAf1rfsk3ZOOghH9SXisPNVTapecTwFoQrkhuHZC+
	Pkn5mDQNj5x1MHkaacuF1rlTy/5ihNGAxSeNgLt+Y8XQH8ECWFQekHShjG8i05M5uJZkurhCExZ
	DD5RwF0VZhPhbKWd4trwWXLcBcZk0dI9zDpAmjYQgF0OMS9erCT9GrfvwV49e/Qa8osFJsGv
X-Google-Smtp-Source: AGHT+IFwTIvZ/JDXp63lVD7yCHCYF/5x6H0kXJQDeAXO5fUwzIWcY8Yr2zXT/J8iEsgfDbopaGw9rw==
X-Received: by 2002:a17:906:bf46:b0:ac7:ec31:deb0 with SMTP id a640c23a62f3a-ad218e91c5fmr193282666b.9.1746771127738;
        Thu, 08 May 2025 23:12:07 -0700 (PDT)
Received: from jiri-mlt.client.nvidia.com ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad2197c5b9csm98887566b.159.2025.05.08.23.12.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 May 2025 23:12:07 -0700 (PDT)
Date: Fri, 9 May 2025 08:11:56 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>
Cc: "donald.hunter@gmail.com" <donald.hunter@gmail.com>, 
	"kuba@kernel.org" <kuba@kernel.org>, "davem@davemloft.net" <davem@davemloft.net>, 
	"edumazet@google.com" <edumazet@google.com>, "pabeni@redhat.com" <pabeni@redhat.com>, 
	"horms@kernel.org" <horms@kernel.org>, "vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>, 
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>, 
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "saeedm@nvidia.com" <saeedm@nvidia.com>, 
	"leon@kernel.org" <leon@kernel.org>, "tariqt@nvidia.com" <tariqt@nvidia.com>, 
	"jonathan.lemon@gmail.com" <jonathan.lemon@gmail.com>, "richardcochran@gmail.com" <richardcochran@gmail.com>, 
	"Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>, "Olech, Milena" <milena.olech@intel.com>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>, "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH net-next v3 1/3] dpll: add phase-offset-monitor feature
 to netlink spec
Message-ID: <zosr5eqz5sh2z5uqxghdko2fug2zlzr6dbwbmavesiysabvvgj@zr6pxggacpwg>
References: <20250508122128.1216231-1-arkadiusz.kubalewski@intel.com>
 <20250508122128.1216231-2-arkadiusz.kubalewski@intel.com>
 <timzeiuivkgvdzmyafp752acgfkieuqhivcab55x24ow7apovp@4lsq6esrrusg>
 <SJ2PR11MB845211DED1A8ECD92116E0019B8BA@SJ2PR11MB8452.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SJ2PR11MB845211DED1A8ECD92116E0019B8BA@SJ2PR11MB8452.namprd11.prod.outlook.com>

Thu, May 08, 2025 at 05:29:07PM +0200, arkadiusz.kubalewski@intel.com wrote:
>>From: Jiri Pirko <jiri@resnulli.us>
>>Sent: Thursday, May 8, 2025 4:26 PM
>>
>>Thu, May 08, 2025 at 02:21:26PM +0200, arkadiusz.kubalewski@intel.com
>>wrote:
>>>Add enum dpll_feature_state for control over features.
>>>
>>>Add dpll device level attribute:
>>>DPLL_A_PHASE_OFFSET_MONITOR - to allow control over a phase offset monitor
>>>feature. Attribute is present and shall return current state of a feature
>>>(enum dpll_feature_state), if the device driver provides such capability,
>>>otherwie attribute shall not be present.
>>>
>>>Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
>>>Reviewed-by: Milena Olech <milena.olech@intel.com>
>>>Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
>>>---
>>>v3:
>>>- replace feature flags and capabilities with per feature attribute
>>>  approach,
>>>- add dpll documentation for phase-offset-monitor feature.
>>>---
>>> Documentation/driver-api/dpll.rst     | 16 ++++++++++++++++
>>> Documentation/netlink/specs/dpll.yaml | 24 ++++++++++++++++++++++++
>>> drivers/dpll/dpll_nl.c                |  5 +++--
>>> include/uapi/linux/dpll.h             | 12 ++++++++++++
>>> 4 files changed, 55 insertions(+), 2 deletions(-)
>>>
>>>diff --git a/Documentation/driver-api/dpll.rst b/Documentation/driver-
>>>api/dpll.rst
>>>index e6855cd37e85..04efb425b411 100644
>>>--- a/Documentation/driver-api/dpll.rst
>>>+++ b/Documentation/driver-api/dpll.rst
>>>@@ -214,6 +214,22 @@ offset values are fractional with 3-digit decimal
>>>places and shell be
>>> divided with ``DPLL_PIN_PHASE_OFFSET_DIVIDER`` to get integer part and
>>> modulo divided to get fractional part.
>>>
>>>+Phase offset monitor
>>>+====================
>>>+
>>>+Phase offset measurement is typically performed against the current
>>>active
>>>+source. However, some DPLL (Digital Phase-Locked Loop) devices may offer
>>>+the capability to monitor phase offsets across all available inputs.
>>>+The attribute and current feature state shall be included in the response
>>>+message of the ``DPLL_CMD_DEVICE_GET`` command for supported DPLL
>>devices.
>>>+In such cases, users can also control the feature using the
>>>+``DPLL_CMD_DEVICE_SET`` command by setting the ``enum
>>>dpll_feature_state``
>>>+values for the attribute.
>>>+
>>>+  =============================== ========================
>>>+  ``DPLL_A_PHASE_OFFSET_MONITOR`` attr state of a feature
>>>+  =============================== ========================
>>>+
>>> Embedded SYNC
>>> =============
>>>
>>>diff --git a/Documentation/netlink/specs/dpll.yaml
>>>b/Documentation/netlink/specs/dpll.yaml
>>>index 8feefeae5376..e9774678b3f3 100644
>>>--- a/Documentation/netlink/specs/dpll.yaml
>>>+++ b/Documentation/netlink/specs/dpll.yaml
>>>@@ -240,6 +240,20 @@ definitions:
>>>       integer part of a measured phase offset value.
>>>       Value of (DPLL_A_PHASE_OFFSET % DPLL_PHASE_OFFSET_DIVIDER) is a
>>>       fractional part of a measured phase offset value.
>>>+  -
>>>+    type: enum
>>>+    name: feature-state
>>>+    doc: |
>>>+      Allow control (enable/disable) and status checking over features.
>>>+    entries:
>>>+      -
>>>+        name: disable
>>>+        doc: |
>>>+          feature shall be disabled
>>>+      -
>>>+        name: enable
>>>+        doc: |
>>>+          feature shall be enabled
>>
>>Is it necessary to introduce an enum for simple bool?
>>I mean, we used to handle this by U8 attr with 0/1 value. Idk what's the
>>usual way carry boolean values to do this these days, but enum looks
>>like overkill.
>>
>
>Well, yeah.. tricky.. There is no bool type in the attribute types?
>Input/output pin direction or eec/pps dpll types are also 2-value-enums
>we use same way..
>
>Had to use something as it is better then plain 0/1, also those values
>could be reused for any other feature.

Okay, I don't mind.

>
>Thank you!
>Arkadiusz
> 
>[...]


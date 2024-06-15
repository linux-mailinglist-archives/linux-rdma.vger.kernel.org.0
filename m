Return-Path: <linux-rdma+bounces-3155-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC7529094F6
	for <lists+linux-rdma@lfdr.de>; Sat, 15 Jun 2024 02:10:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDE551C2105C
	for <lists+linux-rdma@lfdr.de>; Sat, 15 Jun 2024 00:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D452B635;
	Sat, 15 Jun 2024 00:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="p3iX5pcc"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D17623
	for <linux-rdma@vger.kernel.org>; Sat, 15 Jun 2024 00:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718410245; cv=none; b=Wy9PbU1kooxsG50pjOPFKjIHo99YpmYWajAJTa3M0yGefv4srgfxWMKhPliMfukUGYMnWQenRBlsp/Mv399GagoQLTetIjwMW3D9aFElRuV0vyU0KaBKuvxbO1gZzL38IPzXxHhwcduvMhaUcPwBTM5ltnsSL34rkkhflY982CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718410245; c=relaxed/simple;
	bh=gNewejaBAdSyW6TmuZ4lHfjXg+C8jYnOyd0Gqj1kBkQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oyLgIaDSj5W/tQqTM0HTDLhG1rvhZxmEo/KTYP8zUBMBWC0o6w2VSiOKkfsPqpcyZm8Jvt/vkDmvzyu6AOV5ZvRpgMFy+Bly676t555ZNxm6DEYJMvje54IuaHjHjr5u80La2h4vxcJCfOxJJe1GmFvhi2e+2nimqoOpNiNr6vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=p3iX5pcc; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-6f99555c922so1514701a34.3
        for <linux-rdma@vger.kernel.org>; Fri, 14 Jun 2024 17:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1718410243; x=1719015043; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IDFKg2giSlNRp2CWnI6wzIZGjcEuH3CutRdpX5N8j6g=;
        b=p3iX5pcciietJf8MyQs5x5zoqEMz/q2yy7lid8CdVWiVelJjom+PPTA1MPnxmztpv1
         LbfXbwtYiiWdN5SWzVqsEe8UrS8JJ3Z6Zh0Pzv+bPEm3hoxkPRWwVMbe8D2runXP3FfG
         bnfyryj20kXv4yN83Acdt5R+0fM/TCnUhWXX5yGY7pYaXgLhdOGv+NJcL89ljdHFS975
         AXHLISu+fcUy2RrL6Ci6zga1w/cEPdI8rZTZcLLjrvwBLNfXFfAt188NYJq4aIRxR7BT
         asHjiiw78MFI8Z5Xynk/uwrZSnUkruXyvR+pu6G+OPU/Rk2LIvp8dldoxc5kj6TQf9Kg
         55Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718410243; x=1719015043;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IDFKg2giSlNRp2CWnI6wzIZGjcEuH3CutRdpX5N8j6g=;
        b=JU3qpOELh5oKIx1Y5ZK+XJP8JijL2CHQASQbg5Dg43cOBpc4iBeOnFNG7uAHz6odNY
         gMSlN5cJl03jK14rLx85huU7D4qdQ5vmxxvRm2uNhVtjc/RDziusomzX/zgEyuMZAXtr
         v1SEh1wdGzmFCfuZpW0fok1lVFqUlH8JW6csBdr9oTk7S1Lhv6zi6Nxx6DD9rcFWixh7
         3fCCAMIldKX7b3qReSPEKs6r2Ch57SJML6QTO1QS1c8tJ8vOmMJh+uUgo50ntVo0ydo8
         onEM0XJM8o4S2hWW4SV3Ma0Z+vxiVzdMCcqaeWAID7VpiM1t4adU1X3t+s6dKuVhpNVq
         qS+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWbQuh5iDEdwL9nIURsHgHWpSD0IpYgfvrnr4/LQ5bGujh+f/51dwvRIkGMCpJLxxQEzcbzPuRUaccUK/x5KcKMDhCcRB/r1r6c6g==
X-Gm-Message-State: AOJu0YxarhOmU071jBuKWSSEtsyEVSZoDn4ExLeUd0xQPkkhc0ahQxFf
	NOOlRlQjzeHcoZRn6QAdfe5AgxW7MFxqB5dEhNkh2U/F6QHaDWJuRz4Ocy4jx/5RXM2wTIrt19a
	L
X-Google-Smtp-Source: AGHT+IETiLeYvMfLS5qJj9lv2YNeygiz2aZ7N7GNkbFdmRrbP/g2iRj/7hvSY6Q5nrBEuc1N17ZyFw==
X-Received: by 2002:a05:6870:f145:b0:258:37f4:755c with SMTP id 586e51a60fabf-25842b0cfa0mr4379647fac.46.1718410243257;
        Fri, 14 Jun 2024 17:10:43 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705cd498aeesm3574633b3a.23.2024.06.14.17.10.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 17:10:42 -0700 (PDT)
Date: Fri, 14 Jun 2024 17:10:41 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Omer Shpigelman <oshpigelman@habana.ai>
Cc: linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
 netdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 ogabbay@kernel.org, zyehudai@habana.ai
Subject: Re: [PATCH 09/15] net: hbl_en: add habanalabs Ethernet driver
Message-ID: <20240614171041.7b880232@hermes.local>
In-Reply-To: <20240613082208.1439968-10-oshpigelman@habana.ai>
References: <20240613082208.1439968-1-oshpigelman@habana.ai>
	<20240613082208.1439968-10-oshpigelman@habana.ai>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 13 Jun 2024 11:22:02 +0300
Omer Shpigelman <oshpigelman@habana.ai> wrote:

> +static int hbl_en_ports_reopen(struct hbl_aux_dev *aux_dev)
> +{
> +	struct hbl_en_device *hdev = aux_dev->priv;
> +	struct hbl_en_port *port;
> +	int rc = 0, i;
> +
> +	for (i = 0; i < hdev->max_num_of_ports; i++) {
> +		if (!(hdev->ports_mask & BIT(i)))
> +			continue;
> +
> +		port = &hdev->ports[i];
> +
> +		/* It could be that the port was shutdown by 'ip link set down' and there is no need
> +		 * in reopening it.
> +		 * Since we mark the ports as in reset even if they are disabled, we clear the flag
> +		 * here anyway.
> +		 * See hbl_en_ports_stop_prepare() for more info.
> +		 */
> +		if (!netif_running(port->ndev)) {
> +			atomic_set(&port->in_reset, 0);
> +			continue;
> +		}
> +

Rather than duplicating network device state in your own flags, it would be better to use
existing infrastructure. Read Documentation/networking/operstates.rst

Then you could also get rid of the kludge timer stuff in hbl_en_close().



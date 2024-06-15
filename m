Return-Path: <linux-rdma+bounces-3156-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D14399094FB
	for <lists+linux-rdma@lfdr.de>; Sat, 15 Jun 2024 02:16:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 042EA1C213A2
	for <lists+linux-rdma@lfdr.de>; Sat, 15 Jun 2024 00:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B72431C2E;
	Sat, 15 Jun 2024 00:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="UTUX4AJr"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4158410F7
	for <linux-rdma@vger.kernel.org>; Sat, 15 Jun 2024 00:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718410582; cv=none; b=K7EsjZzW+2Ezo6N9fvycszlX8ZXlLJ/KNXI0CjFsFmAl2R0ZnQ7wQNBd+YYj9lLeNqPUrth8/1TTzIf1zitSFGyOPcIYUDFwshLeRAJMo7KhYtQhIqphG0vjxhpESkzgR27XbmWvDgQx9F0r2e175UyHzQSQw/z5PnE0WKWt4hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718410582; c=relaxed/simple;
	bh=Ah9XF3VhfC6uL+Y7yxuXm+X0XsWWOB0OHtRfi0aa7Tk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KtEBEjXw8QimtfgkMwlqHHNUuAdMfxf8ZcyJp5iB/26IFI5i+qHJNzL7V+HCAeYG+QV+E5jsO2qKo3fSW0rA/juStWRtujDafLz6xfWgI/2/BUlrLbAA9wzDTXUB5nJ9vj9M6XPrzXk2J0dnHTkhU7+pJFwY3j3Rhw6+Oo19UKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=UTUX4AJr; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-704090c11easo2391028b3a.2
        for <linux-rdma@vger.kernel.org>; Fri, 14 Jun 2024 17:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1718410580; x=1719015380; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dbQfy6Bm8n8TNDG5hBa+dXfTA5IW7C1pPdTr7l75iCw=;
        b=UTUX4AJrJlz2ePVxj+nYvXt1eBakA5iu62o7NvcvIYyuz0Xi72kSsRU/1pAPTwIXGB
         591lsNDTVTOR6KPj39/hPWN5GrDCF+H7Q7uwctOv2iaLZEno6LJz/s6mfn9QQpOx/X+3
         9g61QqesRNB++i5VFJTjDMGuWAeSeW1sFRS+tLHyOr+xPGHEPcoXjVM6sE4OQA2DTH1J
         du52YAW2SP1yCtNpQBX2Cr9EHewQYq4VDR7o2kokOY0cHtzVsEszRieqsaKeb9lUzd6S
         3lt4mTDtVH7PPqpQmZcsXss6kbjtYX29YvbmuNsbt2WmCp6Gxxo4gurLXYlwMlhOTz8y
         Tkcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718410580; x=1719015380;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dbQfy6Bm8n8TNDG5hBa+dXfTA5IW7C1pPdTr7l75iCw=;
        b=RG3gZUmOfigCZF3+NRnokprjYyMNasdCSMBv65N7b3HUqkGKafeKlS8ZeXCNDDSQn5
         nAlMSVOLYUZn3Cy09nlraIenAK1ILWAGLms5epMge4Kz8ZFgJYXDqblfNJV8OOYfOxSj
         iOKPpV2eQj1ZtIrxJ6P4n1uHgx9/VEzVfMtqBWOfY77FX7NDoCVdr3Q6NkNce4IsWE+l
         WmgeyHgFIBvA7fZDzSaVS682KDqNP5N04wG4G3BpcHM681u7FHE/JMxglbhwPmm35hvs
         ZQ8IDXBqaWFXtIOoMq8hP0m0T6UAbcK9hnjY9EsHa7OnCirwYE1ZBYDsGkkpyaFGbt1y
         v5Eg==
X-Forwarded-Encrypted: i=1; AJvYcCUTYciwgh2YXvyXYGO3ciMSPFB9pfAb1QIwGC+MEUXhv9xoTz+eZo9OiQQuXuYj+nlorTX3BV3AU8h/twCjCdH4XGHSavkF35CBEQ==
X-Gm-Message-State: AOJu0YxO+0eGDYvZ8XyTFLafceNWn6vW/1Liw/vv/3qzhHCFdmaL/4WS
	RmxZ/bXSx/jFYNDf6/86rdTkxdC3YZkE7PZU1RM5FDMZdsv59btycibYSY9AtQ0=
X-Google-Smtp-Source: AGHT+IGnrXmEyH8r24NhyhAqUyF2qFmWVTxhyF32OwfqT86eX9M8aSQDG2YlmH6KZDu1FSFJOoZ/0A==
X-Received: by 2002:a05:6a20:d80d:b0:1b2:cf6c:d5ae with SMTP id adf61e73a8af0-1bae844443cmr4560825637.59.1718410580416;
        Fri, 14 Jun 2024 17:16:20 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705cc967334sm3638921b3a.57.2024.06.14.17.16.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 17:16:20 -0700 (PDT)
Date: Fri, 14 Jun 2024 17:16:18 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Omer Shpigelman <oshpigelman@habana.ai>
Cc: linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
 netdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 ogabbay@kernel.org, zyehudai@habana.ai
Subject: Re: [PATCH 09/15] net: hbl_en: add habanalabs Ethernet driver
Message-ID: <20240614171618.3b65b3c9@hermes.local>
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

> +
> +/* get the src IP as it is done in devinet_ioctl() */
> +static int hbl_en_get_src_ip(struct hbl_aux_dev *aux_dev, u32 port_idx, u32 *src_ip)
> +{
> +	struct hbl_en_port *port = HBL_EN_PORT(aux_dev, port_idx);
> +	struct net_device *ndev = port->ndev;
> +	struct in_device *in_dev;
> +	struct in_ifaddr *ifa;
> +	int rc = 0;
> +
> +	/* for the case where no src IP is configured */
> +	*src_ip = 0;
> +
> +	/* rtnl lock should be acquired in relevant flows before taking configuration lock */
> +	if (!rtnl_is_locked()) {
> +		netdev_err(port->ndev, "Rtnl lock is not acquired, can't proceed\n");
> +		rc = -EFAULT;
> +		goto out;
> +	}
> +
> +	in_dev = __in_dev_get_rtnl(ndev);
> +	if (!in_dev) {
> +		netdev_err(port->ndev, "Failed to get IPv4 struct\n");
> +		rc = -EFAULT;
> +		goto out;
> +	}
> +
> +	ifa = rtnl_dereference(in_dev->ifa_list);
> +
> +	while (ifa) {
> +		if (!strcmp(ndev->name, ifa->ifa_label)) {
> +			/* convert the BE to native and later on it will be
> +			 * written to the HW as LE in QPC_SET
> +			 */
> +			*src_ip = be32_to_cpu(ifa->ifa_local);
> +			break;
> +		}
> +		ifa = rtnl_dereference(ifa->ifa_next);
> +	}
> +out:
> +	return rc;
> +}

Does this device require IPv4? What about users and infrastructures that use IPv6 only?
IPv4 is legacy at this point.


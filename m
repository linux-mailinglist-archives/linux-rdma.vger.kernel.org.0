Return-Path: <linux-rdma+bounces-16999-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kDzeLMHZlWmmVQIAu9opvQ
	(envelope-from <linux-rdma+bounces-16999-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Feb 2026 16:24:49 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 39D441575FF
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Feb 2026 16:24:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 11CFC300FEDD
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Feb 2026 15:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AB4833A9F0;
	Wed, 18 Feb 2026 15:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bldJyuVE"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0375D303A02
	for <linux-rdma@vger.kernel.org>; Wed, 18 Feb 2026 15:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771428258; cv=pass; b=ZjaCHBikDK15HZOf6sI5OV/Zjw22jFHGOQUpvjF3kVxb9djMpmtIXYqG92/VdH2AP/KAoBCVWtQ/lM1jk38h2XwzqSVmjfoOlVFYXUqkKKm82AU3fcqX9pwfnUclYBf6AKe+dqo2TeaRrbIp+Yef+GFRpVY2RtgIgCPe5tr2gjw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771428258; c=relaxed/simple;
	bh=VpkjTI/7tY22zRQrWlYlhJ0gtlLGfue6g8h3J22DLOw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aqbMUg+gfgIMoQzkwn7m+BSRLDeawJPcF1Nw+liWMKpqMOOMJGwOCo773BTho6mQVZkV6rORqyg/d+navK6jbdD/dny2MZePTeQXRgJzgeoHWH+sHtdze3+VBlfa8XPi+i3SJS2O67Ii9X+/8+fofoyEYGIxT3UHv/SxrZgc1JA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bldJyuVE; arc=pass smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6581234d208so9285758a12.3
        for <linux-rdma@vger.kernel.org>; Wed, 18 Feb 2026 07:24:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771428255; cv=none;
        d=google.com; s=arc-20240605;
        b=KgulxHbDFN/Sy+AxG8wBvrb/PAtUZuwbUxSZaDkLn3YiaHGMQfTA9lhoeFeYvEeyE/
         yI+Pihl573IV6qeqwn2ha7qsEnQV4GRY7mEK2KRNETue2KtnO+lFvbLXYOqrRkqj4Cve
         HPC6uLguLcPCDtGr8Nai0IZjT3mxyJDHAKb7pB1ZyabPI0Cy/Rea60/n5THh9YusrnOh
         Feyqtt4onAdleJtnauNX4E+3AMGFo+O1252yNSEfaj2Jb6/GI5KMhsEVz2SJQU08Y9p+
         bqHXKYwHEU/P/bigszzKmQaAkItUk9bMzOxMP8pBg1F9/1L1x1AHzDT1cZiP4tlloZDt
         6Luw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=VpkjTI/7tY22zRQrWlYlhJ0gtlLGfue6g8h3J22DLOw=;
        fh=eF2R6zhjYLQMHDDfBIGy6GVUIag6XQcUSQIuhpWjTVA=;
        b=EoMTqX/H1CBo9qtKpORGc22cjq5bxfRGx96WjEOmmDX4gVab5gi0Y9+04205psxrhz
         gq0XGr44Ps8McPLSk6frtpUEXAjbfMDOcA+uhwfQZSkx6bAFqVrxw17irAXpgGdB/bfd
         WHIoIXiW9/Qvoa+PPLcVxs/33XAI5+cmgLOdhhRT9IzCJ9F6z91pMa6UBRQhHMfp5yaM
         y8gS3N6MArnBRmmN4EcUJHfMSKbuFH4iMnhePYIAmwtzikRcAwNMRnXFcV2MuvAKIWJR
         fnaEbe8OAar2nqbVk0KgWR06DCcQtrFaysExKQpZT+YwTN/5paCCxvYcf5Yj8l7ScYaI
         T9tA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771428255; x=1772033055; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VpkjTI/7tY22zRQrWlYlhJ0gtlLGfue6g8h3J22DLOw=;
        b=bldJyuVE7Nr7rzQfymXm5CMFAz52wLOW6UlLiCeLXgv4K8vWmDcKTXioBs6eWA5oum
         7iFMZCpCr5KsitNYEVwPTKJTGs29eWO+SPtPYru7bS8QF/zkVtewIjQbAQNTZvf2SMKs
         aSuWSUJXYS27btkYrEJHbdcT9p2AJKWOm6+NwL2aPZxw3DkYZ2G2/L+BvPe+vHBrZAxM
         skmYuF9gkSCzpVQ+bB9Jq22HD5EjSZvNu15NGLxOXGuvGAWJp/uLzcMMo+Z2I2EXdMhw
         XxWgjv7BTFXk/mwGvOpADpyQPni9WapAOuUljurZ3q5mNAFD1bK5/QDaxfta5BpaM1Te
         D4sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771428255; x=1772033055;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VpkjTI/7tY22zRQrWlYlhJ0gtlLGfue6g8h3J22DLOw=;
        b=AS9xofvIaEbrgx0RyYxga9f85bc3uzuP1lmpb+pfgB5zwtK23l/8+kot0qupzd91uJ
         wLZi+b2OMEhHGctR+JV+thV98RvMAviWoEnQAJFepCrTJRO0BROjhOTqNMM4/aqlGQHZ
         /omEj3SL6e0bt/IkEW7Hg5bNFYRH+4JlaLBUpmJkDOxxwuKMup1+/IjuiDpGQ9yUZP6R
         egnpAdvFRfOZISxHpAT6OgtfRYpCGJYYGEyuhWPBYOEUcs+/zekzGFcmLaWL5oklR5RB
         bTmhOrgvoIbIzZFYjBW8U2qLYxzbDfHJygwsDGWWadM7uwAgMr6QiYWO9RV5MpNQcZiM
         Hg+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXQ1kNsipkLXrC2AufJPNkaYPKA/mhnvMl6n+tZJeUU7Rp246wOU839Cm5Yx7wDH7f1S+WtzxSRReIw@vger.kernel.org
X-Gm-Message-State: AOJu0YyxBZL6j7va3W/F1OPgiUKU1yQvXB8fUhVyEMedDZreuV62AHza
	NqC1oBQAaJMp7S14zktWzrSoEK8bBD9McSbSpWzMIZX8y7SuVKvUM2W0ADXSHDOxEVugsvxfHfT
	IjKFIOOwV42cdbMkbgTXLvpOxGfjMbV8bkmMEKM4x
X-Gm-Gg: AZuq6aJ1G0oQkk2owStQNXqQ8VM6xvKgJSuHYqriTOF0tcNTY5rTWaPYUOMo0kWZtgg
	11KMw69IqfkF7zkS9Hoie3IwHShp9ogMpzox/8hYN4VNfqGN7SgqWKCpC6d+/LqCdDZVborVGh9
	Pv36UgoWP9XJsJRmoRtphdJIGC+jMKBaxNtfHAQl4tndMQKd7yJqV8O899F7BpHYefP3iYqP5BS
	sSUr2sw9/rJNIVBR5Kdy6zCHscUm/xLJnxTdN6Lr61/Gpfi5CTT8aVNkVLLGYJW+WuZUcfi4S+W
	g1flNPeG0ZXwGL8/dfEvmUQdGHKXKXQb0XMAOQ==
X-Received: by 2002:a17:907:ea8:b0:b87:2c88:ce40 with SMTP id
 a640c23a62f3a-b8fc3b5961dmr949452566b.27.1771428254785; Wed, 18 Feb 2026
 07:24:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260217182116.1726438-1-jmoroni@google.com> <20260217184559.GP750753@ziepe.ca>
 <CAHYDg1QdYZjT81gB6geWKpeRR1TEPKnk9XD1eXcMriVAOHCo4w@mail.gmail.com>
 <20260217232158.GQ750753@ziepe.ca> <20260218090509.GD10368@unreal>
In-Reply-To: <20260218090509.GD10368@unreal>
From: Jacob Moroni <jmoroni@google.com>
Date: Wed, 18 Feb 2026 10:24:02 -0500
X-Gm-Features: AaiRm536ml1WbeT0-jEXzz_Z52ouD-hbcN-gr9uQIarez8sd2JIw-TaqVZIVuLE
Message-ID: <CAHYDg1TB1Xa+D700WrvrcQVdgZFE5f8iWp48EmQM9XjK9xJdew@mail.gmail.com>
Subject: Re: [RFC] RDMA/irdma: Add support for revocable dmabuf import
To: Leon Romanovsky <leon@kernel.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, tatyana.e.nikolova@intel.com, krzysztof.czurylo@intel.com, 
	linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jmoroni@google.com,linux-rdma@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-16999-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid];
	TAGGED_RCPT(0.00)[linux-rdma];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[google.com:+]
X-Rspamd-Queue-Id: 39D441575FF
X-Rspamd-Action: no action

Makes sense, thanks.

I'll grab your latest dmabuf changes first (.invalidate_mappings, etc.) and
prepare a new patch soon.

Thanks,
- Jake


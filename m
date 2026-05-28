Return-Path: <linux-rdma+bounces-21430-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6JXTOs0/GGqahwgAu9opvQ
	(envelope-from <linux-rdma+bounces-21430-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 28 May 2026 15:14:53 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DBA95F28BB
	for <lists+linux-rdma@lfdr.de>; Thu, 28 May 2026 15:14:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2832330A79D6
	for <lists+linux-rdma@lfdr.de>; Thu, 28 May 2026 13:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 611D23ED3AA;
	Thu, 28 May 2026 13:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Y5ItgSzD"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B4D3B2FFE
	for <linux-rdma@vger.kernel.org>; Thu, 28 May 2026 13:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779973783; cv=none; b=rrShyrhXVvYKbSvdQ7a8ux/96hvRFZOsCArs4pj6ryeX4L37nciOA/7dPlKD337jtiEZEiE3X74RHJ05HINTDbi/7Ruyz4NVVHoSAX5qoQ8gBwF2/tQXG6hPM/OWnCmxmhuscAq69pWbwCqiJxk4tBgSgw+Us3LPANFSQrALnFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779973783; c=relaxed/simple;
	bh=n4HVP6oE85/rJA1fLV+SQPFp877w/RCZuh8W1eNyI9A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AQVlLLVZb92QPt/mIEDVxus8SWVAYGMmipXqxXgLAYA/R64HPYg3TT25OFAYCDBRgUeo2Jsbdez5+swtaxMCTXJ2Z5AFF0WCUkybdglwAAU9SNzgrD/AKSNDFz7w+AVWp/4tX64C/1YNUaL0mc1oTjrRXHUrqmOFw21aLMJaydI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Y5ItgSzD; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-914bb8e95c2so348159485a.1
        for <linux-rdma@vger.kernel.org>; Thu, 28 May 2026 06:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1779973781; x=1780578581; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=n4HVP6oE85/rJA1fLV+SQPFp877w/RCZuh8W1eNyI9A=;
        b=Y5ItgSzDCxb6xRYv+yahy4VHAOILuRZsviVEyLbU6Sc1Szm+SZO2A8O6EQG2+g//+v
         lPLwMBtoT3LhlMVmJrMNT5+2O6H0U5HDrnKM/DvA2BbAP2O39buMt1KlIrVTV0JMvBCT
         XX1/czD8lqBHK9xMo9K6hSsF63l04N1C47JBU3ztMp64unCEMAPuA3vo+sirpBZng7om
         te+69mrAoehJ0kWLd57SMZQBmvyfemkNnGeO3WUShU5DtwumZitzZLrfV620CNPt6Sy8
         yotb7ZrXDQ7G5JU6UpWcvTVsXoUL2nkx2nlMdKp3rFnyRvECwTJ1HYtPGCc32/6Ta63V
         4AIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779973781; x=1780578581;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n4HVP6oE85/rJA1fLV+SQPFp877w/RCZuh8W1eNyI9A=;
        b=WgnCmxStqr0pZfa0UMCV1ZF9vGUm51oCYO5Wb1Gl8q2iM8P3UcbkdKNOhZLj1WpQRs
         kOclLZtgZjgLE+/u9tgPTqNliX1PIRhJf2hbY/y64Hj8507lO79NYA0mDcKDkwOmYw/X
         Ioz9DeM6odj6mNbz5V7/ejqtz4y8gryuR5gHJtPcb+9NdSqjL+mNd5/kMQb7AejL6qsb
         /kNsMvm1CtsdPEvSjebOiuYmcvfgLKdgu2gqMLqn/lWo75vtB6zSzVTE2JEFVGjwWn1l
         HUJeVYWZ0GdHYcdziaYaYmypl0sWyGlSNuJUJF+k9G6Bs2u3LhibkoQLEKsUCCdlwbja
         HLsQ==
X-Forwarded-Encrypted: i=1; AFNElJ8fe4nimbQG8n7sn4A1bBr0vAlOEy+gDyQHnEFWnL/8Nffuz0wPy6Ik7b+kg38ofI9oKYP+zRJog2hP@vger.kernel.org
X-Gm-Message-State: AOJu0YybprMrhls4sCWPcV/HcI9pBrTk3MX62JX5A5NME2a7S2QklpLv
	ZpcVmNOr3mqFX+4aUIELhDg4zcDDWhr+eXaU/e/7zax2umFu61G0ilBW3QeNrLsILW4=
X-Gm-Gg: Acq92OG0qAk9lmRn232LutSP/5pRigaWLLmCiVVIowv6k5yZ+3RW7KCoS26PYCX4ocs
	TIYHTs3Ky4AtwXN6A2P1a0NZXul9PXccGlEzzHKSBY2g2Jc4/wSY4JYGI8kfBxBN0flxVogFQod
	JVXEiVH6GaGMdyLGN2dZRGKIYfBXrBZSeIu4I8M/E+WbS8TmuCoeF/K/5P+Xj0QrD0GiLBKES3A
	NobqJyWtiCa9xuEr163kVMHNd5BF4CH1o3vPxp+1cElNz7moZUoN//0BGX0bqcPcgGUmrm0v0Xt
	IFtdpLC+2QsBrGwiSgchf4sa472pczEz/L+MUsmXCLCDdXh2aDt+uvur+EFdTVQtEcR2ER6j5sd
	9TaSVI81U6QZjRewhnh/K1I1/vvwuJ9H46A7ojQGhI7sIrRtV/kslPQ6Bpd8VN9l/mjcIoTz3ih
	0MF9tKwTsF1PNXTsbUCopE6l0V0EGUTbwItOPjD+UThMEE5jDqzZqByTDRXtb1vV1A8guGo3EnY
	S8tL5ENQZVvk9/W+OaGhBD+a54=
X-Received: by 2002:a05:620a:390a:b0:914:daf0:d982 with SMTP id af79cd13be357-914daf0dfbamr2666909585a.13.1779973780875;
        Thu, 28 May 2026 06:09:40 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-914f8810a50sm828419385a.41.2026.05.28.06.09.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 06:09:40 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wSaUV-0000000GYFj-3U47;
	Thu, 28 May 2026 10:09:39 -0300
Date: Thu, 28 May 2026 10:09:39 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: luoqing <l1138897701@163.com>
Cc: kees@kernel.org, leon@kernel.org, linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org, luoqing@kylinos.cn,
	markzhang@nvidia.com
Subject: Re: [PATCH] rdma: infiniband: Added __alloc_cq request value Return
 value non-zero value determination
Message-ID: <20260528130939.GP2487554@ziepe.ca>
References: <20260526122329.GC2487554@ziepe.ca>
 <20260528065435.1269299-1-l1138897701@163.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260528065435.1269299-1-l1138897701@163.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	TAGGED_FROM(0.00)[bounces-21430-lists,linux-rdma=lfdr.de];
	DMARC_NA(0.00)[ziepe.ca];
	FREEMAIL_TO(0.00)[163.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ziepe.ca:mid,ziepe.ca:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 4DBA95F28BB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 28, 2026 at 02:54:35PM +0800, luoqing wrote:

> Although this is fundamentally a driver registration issue (drivers
> should specify correct sizes), adding an extra defensive check in
> __ib_alloc_cq() — like ZERO_OR_NULL_PTR(cq) — would:

Then check the driver specified the right sizes when it registered.

But I don't see much value in this avenue, drivers won't work at all
if they are so severely buggy.

This entire conversation is pure AI slop, please stop.

Jason


Return-Path: <linux-rdma+bounces-21334-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KDrtBcwrFmqdigcAu9opvQ
	(envelope-from <linux-rdma+bounces-21334-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 27 May 2026 01:25:00 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 266405DD871
	for <lists+linux-rdma@lfdr.de>; Wed, 27 May 2026 01:24:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A7DA83009F09
	for <lists+linux-rdma@lfdr.de>; Tue, 26 May 2026 23:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD41E3CB2C7;
	Tue, 26 May 2026 23:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZFhy7sp8"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D8F0380FC2
	for <linux-rdma@vger.kernel.org>; Tue, 26 May 2026 23:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779837892; cv=pass; b=QMmGVQ4OW31XYbGABpQkt55qFOvBY/tQgBbsTUzFvuDdDkjr3d0hhyDU64Xlrqn4xmyvIX/Niivv3HSK4EVlR8tLMBnibKu6kU6RdF1p4eC+MqE3XPTm75OIhQtxaevxGgrIfVfkVdT8UU/6Rv5I7doOxUpjVPUWIJOr93nif8U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779837892; c=relaxed/simple;
	bh=Q7sAtjKL+cEjZyGKthSSnLGiIUdUNWZFAmkDO/gAlEA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fSQBgADL0HNqpyppNbVXga1DBldW53uLhqLj4TUchWY7SEYsK318KAHOyPOVQtTPKQBIGaLNDHmK9poLicoqAd8Pr449Y1dJhz7cuRzYmfXkUCzNCkhJQTRMyY6BB/zKWgKgQK/U9Vore88ysxvbtdcMj+EgBD7lj49d4WcDCAc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZFhy7sp8; arc=pass smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-484cf882ce5so7968838b6e.1
        for <linux-rdma@vger.kernel.org>; Tue, 26 May 2026 16:24:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779837890; cv=none;
        d=google.com; s=arc-20240605;
        b=PTyBECvnlxgs8w77uMAsU6NWGqSX6jJ8/AIcU0x5c15gZ15i+3RnalANMegKoua8ut
         HNOlAv0zmq4HfFt0dQCZl/gPJu3uvYl0qRynRrGkxZJ9/pPiQ2vDTLQQ9wiMqbyQvYcZ
         RrA536PKH3RlcTad8mIcNadfwnEzeJ2m2iV2hWgsSUP/dBQqpwSHWrbKF7UrA475oA3I
         XbYe2QkVPa6gPpEK7NYtffp94OAOViDE1SW97jYGsyZ0kwpaqDdskJGSX666O56eqenE
         gTbwFINHez5icGh8odHI8A9hXHYUFt3hVuEVmDOVWnr4m/4ksmkBWHAVY3xw0Rl7NjCj
         sQ+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Q7sAtjKL+cEjZyGKthSSnLGiIUdUNWZFAmkDO/gAlEA=;
        fh=skXsT9xQAJ2tBumqhuthuMMSTqvHRSefC1f+1jdtLlQ=;
        b=JjAdDantcPxyUJJWnNZKMjqA0z4cNTe6kvZYsfai7cive1Tq6bBs0HBoWRbKD27Sj9
         kAbSoP2jmuFbbgUy63DSp+T+/w45/V+c720jVyW9Z6gnGqUtgMaVj1BOlXJA+n/ZOfMP
         xxOcEAHu8jWl+UAsomHgM/LTgChPW6CyS+DTV4rqUgb6hidFvJ6Z4vnW32W4tD51NDLw
         obJDkgF5GiXp3mmdPzB1xWz8zedu0ojlhF51cVBaEKCNCm+8L4XtBTLFh8SI+NxnVIzY
         CyDa9l4nUHDupe1Qapyc/zmI0mG2/OYAwFtj+t3x5eKJmnrTsbH5Z2/gZYlxCrfkCCzG
         RI8Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779837890; x=1780442690; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Q7sAtjKL+cEjZyGKthSSnLGiIUdUNWZFAmkDO/gAlEA=;
        b=ZFhy7sp8P33qBhWAhntj7GL1mbYPzlyqGqthC5IrxQBS/mkYsDYAd1zrIbC+OwVQrz
         Zx57FZCMq2en6B1T3pOwFps46y8aIzMSU4imxGW5jrV5TUkuWLBR6iNYom9HApgpy9nz
         xbNRPzwxJTBsPIe+r0gb6MYtlQQqJ9qIKe1m5LgzZKf0YVLGr0UE5Pack72bwX7G/BBs
         aGopVoG9khkTA25GSl8yxz/Wm+jCi2Ae8wYWBmXJG1N5StLgMtXGzLMxRbLaBAnMlwBi
         cAt0jMrAsLYbvXImuZxRMSaEIex8fZ8fcxUcsrvGolTMKLGOtRLg3uibHeIwIaCX4SZV
         4sVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779837890; x=1780442690;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q7sAtjKL+cEjZyGKthSSnLGiIUdUNWZFAmkDO/gAlEA=;
        b=riVHY3gvbrORsq634WBXbayhVjMUL3gOqZ33sFSzT3SCM8gB2gJyszIDxhBkn5Li5f
         zn2xTZN0dfZJdsJPyXU23ndZNU24SDn1NYCG9FSOaaQW+pzpw+iGRgUID87nO+eAwkBd
         0w4ugm/eu2hEhnMPWeLiZchGi24T+MzQ42KgC//I4QFsrqslcnY3Yq7PDVhJsDhqIsmj
         6TN6I6MQMLA2fTLdSBxrfxeFL9e+VIqs48ScHrzcGHj2o/n9n4NYu3+yv74ahp0fEj1y
         WlgoBAtTx19QYxmLTez9/qUG4xq9fAxKZqbB/eqvWB1Iw4lR4PZKrHMt9nt16X1keJ2z
         tKCQ==
X-Forwarded-Encrypted: i=1; AFNElJ/gIMfI4t/dI2JVuv148w6Y+0p9/HTosT/NaQ+LDDZOg/O5Bu9CP0zy5zRrKHXApMhtSDn4hbP1gZhD@vger.kernel.org
X-Gm-Message-State: AOJu0YxnSXp+fPBih3yJlHDr5NoVnbeMqZcNpjVTMlxY0oa5uKhzMG47
	n69bPjcoKGRIJ2+o2zds0CRBS4mwrmbj+2odJ9VRhQTjQT1tmfyvFcxdimCQJCkTQpR+ZKxYdcK
	0qk5qYycS53k1925Tl6oXxx7C9/tZDHmFzo7BGtJo
X-Gm-Gg: Acq92OEoEMg5E0Y2jqoylkiC47n3TG1hF8KHnltN1IChTkBc/zGEjlqtlipBwnL9x5R
	9sz9+d39/5pO5gNWRRCrfQm1XWc+1qPsJBa7gyZtCVuxcRGYtU4gr4KiRFdoU0kH1PMsYtL6mEK
	yV5OhDLj5aWYXSbWW3idQLvmqtxUO8fxwgNd0i4Bf+KkxNrDd+3XI6fZGheELLFhF37jhdIFj2Y
	vQ0nIl9k4oWMJdUuetbF4f5ZM0GkBc8vaoeC8VHU95x9LaJQvsVEk/gJHg0ZLpT3c/iYQMHDeSR
	wYP7/BnbGrG5Ztl8X5o=
X-Received: by 2002:a05:6808:1189:b0:47b:ccf2:91e1 with SMTP id
 5614622812f47-48549ea8389mr12621507b6e.21.1779837889844; Tue, 26 May 2026
 16:24:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260512183852.614045-1-jmoroni@google.com> <20260525135945.GA2440908@nvidia.com>
In-Reply-To: <20260525135945.GA2440908@nvidia.com>
From: Jacob Moroni <jmoroni@google.com>
Date: Tue, 26 May 2026 19:24:37 -0400
X-Gm-Features: AVHnY4Lq5ErYktBPFnShRR1rFFf3Fvz7xU9rxOB1pOb2SKKwCy2CTzVVUtHY7ds
Message-ID: <CAHYDg1QTg_McOknngpNsmWwBsuMA2mhnb71+fsByfmzp9d7z1Q@mail.gmail.com>
Subject: Re: [PATCH] RDMA/irdma: Fix out-of-bounds write in irdma_copy_user_pgaddrs
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: tatyana.e.nikolova@intel.com, leon@kernel.org, linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21334-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jmoroni@google.com,linux-rdma@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 266405DD871
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thanks!

> Can you also address the unrelated bug sashiko found:

Sure, I will take a look.

- Jake


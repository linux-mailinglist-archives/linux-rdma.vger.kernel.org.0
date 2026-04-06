Return-Path: <linux-rdma+bounces-19021-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2BEMALZ502nPiQcAu9opvQ
	(envelope-from <linux-rdma+bounces-19021-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 06 Apr 2026 11:15:34 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E3383A282D
	for <lists+linux-rdma@lfdr.de>; Mon, 06 Apr 2026 11:15:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EE7A830158A1
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Apr 2026 09:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57FD431E83F;
	Mon,  6 Apr 2026 09:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BwLl4cFI"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC64DF59
	for <linux-rdma@vger.kernel.org>; Mon,  6 Apr 2026 09:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775466922; cv=pass; b=qseKNJqIZTnUzbRN7MKhAge/sFJbdzKk35XUyIti9dcIIk+6tQm1tgBInweBUMzn8np5d9cgVBH9NLhAfL7qORWPHw/HWg2lsnYwpj/Z5KqwNQE3BClaUx+aiyW2FpPdubP7wsAu3HMHHbXRO7wxO1OvwuqbDqfdcg6PUPkHNRI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775466922; c=relaxed/simple;
	bh=HKRZUxx0d6eEo6q2GZbMwkNDM+q5e/G8yBg0maNSgFQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DLForQTGvySsYWR9VGFjAOiaMtjhA1r87x3QHGAI+O6BahB3kBIvLl2OcuUwOXgGHi9+XRNaJn3xNLlpJU9WNzvszIxoLBJkUlfJjSx96zIwQ9k175Qj+E7o90IWbXS1vJbZgLqWR1nEdCt7wwY9KjzERyAYbcBpbUeuJb447+4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BwLl4cFI; arc=pass smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-50d864c23bdso548011cf.1
        for <linux-rdma@vger.kernel.org>; Mon, 06 Apr 2026 02:15:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775466919; cv=none;
        d=google.com; s=arc-20240605;
        b=Z7D+UGRVYbe21Kyi7kTLCL6KP6O+EXLT5GP8eVc4Z8TUf3EBW1OdDRctXtxgXs5iOw
         7hFgjI5yy/KNLSnPAcn2eB+EZKdBdUDHNzW+7Ie5FpmmJflOAzMN2Q2JHgaHfJrdER0F
         4z91TGbiCM8U2K+1windFs91HY2IFIruxF5sdOULdMtUji1Si/ymef7B/3jkg19u6FgZ
         zNyGOAuq7ELHDzakem9wWeU3qV80HH7qQK0VHOoI/MLZO1f5p00Z3s3jNpNF6zpX8sPj
         jvrCkYx0dZnwLPgdjiyez0Qd8R52L0s/adgVWLByZIhHpxS9NMekwAtKLmC1jGydElsn
         509g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HKRZUxx0d6eEo6q2GZbMwkNDM+q5e/G8yBg0maNSgFQ=;
        fh=yFLWFbibU0CY8FjML9Gl7mKwpf5PMupoCUJ39TwrfN4=;
        b=VdfmT4LSP4P0Na+aIxU/1JhIGsAmc+DverNaPhZTZ55wppsFViMTET+D9IXtXCe3XF
         txZgBtpExnCHsPcYLXcD0RHDZCeimS3YEFz5XtRkS2cQikHcd3whNrL7PwGABvukd1Oi
         l/jbLFV2uCKd9eqcJvMq0UWT47VloRexJiG6tomClaiWWHe9ywSwqj15DyrqKJWpEO6i
         1JL85Jf/vDKk3FlrrSM6U6zjdomnv4G4BUjrqbwyUqyaqVkhHl+B9M88wfC7LLp2Rclx
         QLrqrP5YY/xB+Qsts6lLe79MBQGvuEsE3kOKmVwY2u+ZiAaU8UWirgogcyXYmVHRiNx0
         v3Tg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775466919; x=1776071719; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HKRZUxx0d6eEo6q2GZbMwkNDM+q5e/G8yBg0maNSgFQ=;
        b=BwLl4cFIJv+PuFlvtlVLY/trTbLG/ZZRLkfM2d6PClfvPcBYOkuPVcBYOCpaICffuu
         Px7NIAes3wy77d+yH7g+RSJM7RX2uwKTXMiGR4E2QnDrTjdpKMXtuzjbTjzkyAF4QD8E
         16NEEpbEvvVesqJedBzKLVtcVrLeZYdN6JGURcrlFWF1/2OU8ntKg/GepcS827TL+bsB
         vJpCU2rpCKy0gAvhnzyA2ox+ylLoEkEvXbctUBJQ23klCH4Lw3uVHztXTzk2gYV6BF3O
         QFqzGUa/+8VEuX85idvgT1q3lOLxwEVeW80BVjJdXrIjLE5GMkcJzY/illolpUjXxXjp
         hz0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775466919; x=1776071719;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HKRZUxx0d6eEo6q2GZbMwkNDM+q5e/G8yBg0maNSgFQ=;
        b=G75fHJcxwrx7aBbfhet6C/R0LjII/vhLRNACFLBoOAGnJPJceU2iUmNLhKgH1tJWQP
         Qo+5Bu++STR0yzUqSW0aJ92hzwj42cdc6PfHr1qyVne6BMJHjtOOL9vbCwMW5XJF5/V7
         oIhIw+6ybhvWVgZjHlezsiicbMlXzKxI+80TNiXwx6M6DpfF6q6KAQ9zImMqUK4viNZg
         tmQfbFKJioZYsW2tp6nBx4EjBddlUcKffSER+7DwFD+rw4a7Ipkocdxl+PNrshZoDYQT
         C0NUpVqd8jfaeaW6CWneAQi4biswoi0Z3ZH+i9Ov1z+f3ZbI7OC1y3Wd6tqGXkvOiGyc
         CllQ==
X-Forwarded-Encrypted: i=1; AJvYcCV2765igYgEMyHye0QtZoRar3/4sOnPoGBKt/ptplehGiUphQ40puYGCjU9LkA7guKgG4ozIXWjlK6B@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+AQkc+M780O80LN6y0ZuFENtiNBkB3C1zKSxBuhO6s5nmRLeF
	Gmy+oOg4Jta9Q0GBUgUA8/B0BrO85cDX56MP5wmRgHjqQQug9SbVktTj+0/Q9O+fa8ELgRZxhzL
	bcSv8qPxmuV3hSFZlRUNoJ6yMqvW4Smu6+hYgrvTz
X-Gm-Gg: AeBDieu1NYzyd/xhK3iJYcw7KHfcMrfhFZakdijxKKJcnODKm5arFCmOv5nsntBZFxG
	I2pwzMjfG3Dmpkba4u9mmANZAUyT9sYztmEMhb4r3j4rO7k6tC4wJ4s/HJ+lElnvRUHFBRKUFHf
	zRCJjxphY8R3IqReYM7djzrGNnNVKj5Y414VBlY2Uk4qlmRdeC5QrNUNTdDelgmP0WQTcqBsaTd
	wjVWgV86xhfZ3akPTtZOxCFmpVYu40i4STj6OKwvKgP57KUVYVa0bZK6fCBUCKqCNicwe2pgDt/
	4wksRgyI3vRcSI74+fA16sdWu8tZ+hCLDDjL8g==
X-Received: by 2002:a05:622a:244e:b0:509:cd7:aa18 with SMTP id
 d75a77b69052e-50d63fa63b3mr36921051cf.10.1775466918615; Mon, 06 Apr 2026
 02:15:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260402073001.2039625-1-shivajikant@google.com> <azabfvzjn4juc77xdq6qhszd6py6hkb35jgi2xymplpnkj5ra4@vpjpaoeenvlu>
In-Reply-To: <azabfvzjn4juc77xdq6qhszd6py6hkb35jgi2xymplpnkj5ra4@vpjpaoeenvlu>
From: Shivaji Kant <shivajikant@google.com>
Date: Mon, 6 Apr 2026 14:45:07 +0530
X-Gm-Features: AQROBzCBoFtSiCOZ2D6lpeeNP-4-fqlKvW0e9IW54BqrMes9KgUGxPB7EiJOF20
Message-ID: <CAMEhMpnjmbT1YWDstZfWnxOTU8nwreUziYcz6whsxv1TK7KuTw@mail.gmail.com>
Subject: Re: [RFC PATCH v2] nvme: enable PCI P2PDMA support for RDMA transport
To: Henrique Carvalho <henrique.carvalho@suse.com>
Cc: kbusch@kernel.org, axboe@kernel.dk, Christoph Hellwig <hch@lst.de>, sagi@grimberg.me, 
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Pranjal Shrivastava <praan@google.com>, kch@nvidia.com, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19021-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[google.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shivajikant@google.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 5E3383A282D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thanks for reviewing.

On Sun, Apr 5, 2026 at 9:59=E2=80=AFPM Henrique Carvalho
<henrique.carvalho@suse.com> wrote:
>
> Reviewed-by: Henrique Carvalho <henrique.carvalho@suse.com>


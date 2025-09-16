Return-Path: <linux-rdma+bounces-13426-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FD91B59A82
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Sep 2025 16:41:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D85771889028
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Sep 2025 14:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DE6E327A1C;
	Tue, 16 Sep 2025 14:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mVd0sgbY"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51CA732A82A
	for <linux-rdma@vger.kernel.org>; Tue, 16 Sep 2025 14:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758033419; cv=none; b=NwVnPe4HGH5FiQv3AkoKb/YTw/RkYsY7/FKPmN7sNJGpX2wIQvvkpTHFQovgwB0uRv84Szwd/eApdUNbsjJJFJelOpWYbNW+JXW5OF9hF2/HEaBmhqgDddixdK/m4UyXrMQ6HAg7Vv8KiHA+CHDfcNWJo94XUXUR8kkafmlun9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758033419; c=relaxed/simple;
	bh=s4BZfu6yLRiX3AYkgSWl0OqE0hIE2gm8knmVHEguHGg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gqt8DfMrvgnQfq/THPAJruAwAoorAx2PHOAMeNErDWyzKiwNZ6i8nJ1uWdoPBp522scYhTdXQg9/AAqSyNha70oY+M4ffoWqsifYBPHmuehZhDF1JxQRoYI1Rxm7mr0sJ9hFuU8IQsCt7CDuDpTCoAn5DLQ3izKv5aVB+DXuqus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mVd0sgbY; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-336b88c5362so56149101fa.0
        for <linux-rdma@vger.kernel.org>; Tue, 16 Sep 2025 07:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758033415; x=1758638215; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=s4BZfu6yLRiX3AYkgSWl0OqE0hIE2gm8knmVHEguHGg=;
        b=mVd0sgbYtPjacnZQQ4WgJAVG3qFhyQXgoiZoOUh82ko+CYtkEbHX9qLzHsKm34xb4o
         TLHr/4TrHyh2yeKqcZqPhj2j+sQBJ+EDn8O8/WigbIkR8I3UXSd8k0yLR1E/3zwz5L1/
         fbYeVJZcNZ+aATkzc6XHHy55PfkEj2f4WZQgoH5pN3ntIkT5GxLVVuWOvh+thyI0l8bV
         fEH6sdBu4M/HLFr07/Li/3O3MJ9Bfl6hg4pXUsRC7hNSA4CAjUiKdM89R6a5j8DJGUNw
         pC5BaRScrCT3OYZ0Fg47XdLbr6U1KiasRWKTk4p3dx5J8o3yIQvVTp2TkBkQAfIx/oom
         Jq1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758033415; x=1758638215;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s4BZfu6yLRiX3AYkgSWl0OqE0hIE2gm8knmVHEguHGg=;
        b=j1vYsB/aqwIY1UMfdLNJipf7j3PUCz07Gt7JwkgNqsFCZm2ULg0SFr1R9aYpvCHbjX
         ffuYXR/LjWHlZQQcnXz2syizuEkfv5Gi3oIxN39Ys7cJKhDhisi1yApH3O5xx5jQIQDb
         /8OR8JxfqzLyd4Pi+afA2ofwRMq7ihY+2GHS+SWMMf0nNdWl2wFusCbx0UQXHBD+CTBI
         YPidyIPLsdI6cO/T0h1ij7GRX0MMlgVuongFA+fbsP2DA7w4QKzg4hPdswLlMeOAWl1p
         52n0PW6Qr7hqabtv8QQmQiL410Evqn9FMhexsRx4vpXY6i6ciosdT/LRrkIZRsJkPNvH
         htrw==
X-Forwarded-Encrypted: i=1; AJvYcCUkbwKSgeEHbG2yl7cVvZ6jlUZPbTNQrBmQSWCAUQuFKkP9/NwALFrgnDQoeYJKb2hBS3muo2x5N3MK@vger.kernel.org
X-Gm-Message-State: AOJu0YzjzmUSeqDY4KyAh0Sye38p03vIxox2xOVx5qkQjDxgb79tqNKa
	svsJabrbuRDCsBGXp0oWOebaJSO4jJr8JUtayeYvOKPW6FoGNZaMt0lGrawTTsjeEsAQI1Q4Jic
	7iqkuh4aS/WEdyxkI6iPQqSThd1wvEJeOnxcWkcmY
X-Gm-Gg: ASbGncu3deMM96HdG95i1wipl6sjTEm3idtO2XlvyL9jXgasFnfMgZHYZOcIUE7H1pB
	sYcwf0cI5DGQMcSf8FE2vT59g4JAZK//zIPFt5+QjLK95JmuWXi7Nk3yxiki5k9CaT9KxMsu9lX
	XQcLVpSjM7VtnGRpYxPrvngjg6SL9bteaMFy1/POGaYw4KMgUuDRD/zp6mRZa8hcaLtkVU0VY/o
	Kp3+Zz7Khi+9Xpd/ZF1XvKVBuL8eXQrADB5d2vVXg==
X-Google-Smtp-Source: AGHT+IGHaVarPK5xt1Np5K72LY6E/5GXRbs5qLTHuoQWd1viNTNxXfbQAu05Ta7V3ZSw/ahbVVUvd6K4Gn+lu/92W/Y=
X-Received: by 2002:a05:651c:25c1:10b0:336:853d:27fe with SMTP id
 38308e7fff4ca-35139e55aa6mr44793961fa.6.1758033415189; Tue, 16 Sep 2025
 07:36:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250912100525.531102-1-haakon.bugge@oracle.com> <20250916141812.GP882933@ziepe.ca>
In-Reply-To: <20250916141812.GP882933@ziepe.ca>
From: Jacob Moroni <jmoroni@google.com>
Date: Tue, 16 Sep 2025 10:36:43 -0400
X-Gm-Features: AS18NWBPbofJ2OdtXbuVGan0Wupm2O1UZneWM-RcR2E0FqSX7yV-nL-jGzQHCzI
Message-ID: <CAHYDg1Rd=meRaF=AJAXJ+5_hDaJckaZs7DJUtXAY_D2z_a6wsw@mail.gmail.com>
Subject: Re: [PATCH for-next] RDMA/cm: Rate limit destroy CM ID timeout error message
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: =?UTF-8?B?SMOla29uIEJ1Z2dl?= <haakon.bugge@oracle.com>, 
	Leon Romanovsky <leon@kernel.org>, Sean Hefty <shefty@nvidia.com>, 
	Vlad Dumitrescu <vdumitrescu@nvidia.com>, Or Har-Toov <ohartoov@nvidia.com>, 
	Manjunath Patil <manjunath.b.patil@oracle.com>, linux-rdma@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Does this happen when there is a missing send completion?

Asking because I remember triggering this if a device encounters an
unrecoverable
error/VF reset while under heavy RDMA-CM activity (like a large scale
MPI wire-up).

I assumed it was because RDMA-CM was waiting for TX completions that
would never arrive.

Of course, the unrecoverable error/VF reset without generating flush
completions was the real
bug in my case.

- Jake


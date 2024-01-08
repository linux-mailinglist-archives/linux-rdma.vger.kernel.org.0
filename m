Return-Path: <linux-rdma+bounces-562-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAE76827644
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Jan 2024 18:25:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63B02283DE3
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Jan 2024 17:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B63D954676;
	Mon,  8 Jan 2024 17:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="UuVaLoTT"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C1154663
	for <linux-rdma@vger.kernel.org>; Mon,  8 Jan 2024 17:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1d4a2526a7eso7497785ad.3
        for <linux-rdma@vger.kernel.org>; Mon, 08 Jan 2024 09:25:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1704734703; x=1705339503; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xigDf6p28CHQW5GASRC2U/QP3WPS1bpkxmr/AK2xnu8=;
        b=UuVaLoTTaHR7BJyqAl5Ymf/Bfeq4yg4+bRnFTWFMrCl55Tvh3U0qN5KPKIQfHBJNgM
         UTe1Kn+Mog93MAIwwkj1srsp7+oq9R6ovOGOMr5tIhjWeYs7G9Gfaqvl0Qqli/WLP/J5
         a8oWaEu3fTA0A29OiCCaPg+2PXf0UNNTNc1Sy/G4iqjHXxxUXpJ8hgreGQxo22UoUKTX
         on/6Jma3SZkZV6cyOjX/hgPQnHsE2XawAwPfwjB8iIlXRsRGgCHyxK48fVd7WeRiqZEw
         /9UtLyZlL6QRFJjPp4Ko6NU7q42vrPR9bX11NjrI4f6w4aEjnYFN6eJm/Oi910VliArs
         go9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704734703; x=1705339503;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xigDf6p28CHQW5GASRC2U/QP3WPS1bpkxmr/AK2xnu8=;
        b=FHEov56pLOk1PBjW9i2R5oNtlQNdAcBbokFzQuRFX4UOSmkQZ7FFsm5b1rX2LWK3mz
         tWGCaY4urAvHbtSeWpo7zdLyaWHQT+I8wNP9Mc7d598Soqq4Voz/Oh6+p+yodGstgYUN
         iqrvnL6a/+HeDncmaI3kxNXJ6iXeSEgcLsCuBYK4AuK3jpjIzXNKiZRWLlTtUG0F6yiV
         0srZaHvc9MhOTNhcGKruuOB6M+NGQ/fTDILU/VRVF/7411wJyjNByY+zpqyLtob0Swj7
         QVlTGfqV8j3+syZzC0oIQrplr1akWgGuMyFjw1nt3R3DEX4vYEx7OHIelVlxuECoNMIS
         G+Zg==
X-Gm-Message-State: AOJu0Ywl9FW4n0bgpOMucSIJFFlAvZfF/P0kFL8DNre4z6B1VMjEF6bq
	9qRsZ8rg1iYUVh5LrovoQr9Cw/NR8FSlvw==
X-Google-Smtp-Source: AGHT+IHH3uGNyh2vnYfaduYWr7IUrNLKJAQp6S1iocIb5ZDcbQeRBkSVwCdISmKSQmp35VPAy49mhw==
X-Received: by 2002:a17:902:7c98:b0:1d0:c4af:4635 with SMTP id y24-20020a1709027c9800b001d0c4af4635mr1604540pll.98.1704734703458;
        Mon, 08 Jan 2024 09:25:03 -0800 (PST)
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id g2-20020a170902740200b001d09c539c96sm142498pll.229.2024.01.08.09.25.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 09:25:03 -0800 (PST)
Date: Mon, 8 Jan 2024 09:25:00 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Andrea Claudi <aclaudi@redhat.com>
Cc: Junxian Huang <huangjunxian6@hisilicon.com>, jgg@ziepe.ca,
 leon@kernel.org, dsahern@gmail.com, Chengchang Tang
 <tangchengchang@huawei.com>, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linuxarm@huawei.com,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH iproute2-rc 2/2] rdma: Fix the error of accessing string
 variable outside the lifecycle
Message-ID: <20240108092500.5772bf66@hermes.local>
In-Reply-To: <ZZweXDQ-4ZrlfxBv@renaissance-vector>
References: <20231229065241.554726-1-huangjunxian6@hisilicon.com>
	<20231229065241.554726-3-huangjunxian6@hisilicon.com>
	<fb7c85a4-165d-7eda-740a-d11a32cb86c0@hisilicon.com>
	<ZZweXDQ-4ZrlfxBv@renaissance-vector>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 8 Jan 2024 17:10:04 +0100
Andrea Claudi <aclaudi@redhat.com> wrote:

> On Mon, Jan 08, 2024 at 09:28:52AM +0800, Junxian Huang wrote:
> > 
> > Hi all,
> > 
> > the first patch is replaced by Stephen's latest patches. Are there any
> > comments to this patch?
> > 
> > Thanks,
> > Junxian
> >
> > On 2023/12/29 14:52, Junxian Huang wrote:  
> > > From: wenglianfa <wenglianfa@huawei.com>
> > > 
> > > All these SPRINT_BUF(b) definitions are inside the 'if' block, but
> > > accessed outside the 'if' block through the pointers 'comm'. This
> > > leads to empty 'comm' attribute when querying resource information.
> > > So move the definitions to the beginning of the functions to extend
> > > their life cycle.
> > > 
> > > Before:
> > > $ rdma res show srq
> > > dev hns_0 srqn 0 type BASIC lqpn 18 pdn 5 pid 7775 comm
> > > 
> > > After:
> > > $ rdma res show srq
> > > dev hns_0 srqn 0 type BASIC lqpn 18 pdn 5 pid 7775 comm ib_send_bw
> > > 
> > > Fixes: 1808f002dfdd ("lib/fs: fix memory leak in get_task_name()")
> > > Signed-off-by: wenglianfa <wenglianfa@huawei.com>
> > > Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
> > > ---  
> 
> Hi Junxian,
> For future patches, you can have a faster feedback adding to cc the
> author of the original patch. In this case it's me, so here's my
> 
> Acked-by: Andrea Claudi <aclaudi@redhat.com>
> 

I just merged this one


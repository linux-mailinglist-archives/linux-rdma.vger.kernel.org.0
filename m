Return-Path: <linux-rdma+bounces-506-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9798E8200C2
	for <lists+linux-rdma@lfdr.de>; Fri, 29 Dec 2023 18:21:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0861F1F22260
	for <lists+linux-rdma@lfdr.de>; Fri, 29 Dec 2023 17:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09FA812B7C;
	Fri, 29 Dec 2023 17:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="oF9sd+cO"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C9812B6B
	for <linux-rdma@vger.kernel.org>; Fri, 29 Dec 2023 17:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1d426ad4433so24587465ad.0
        for <linux-rdma@vger.kernel.org>; Fri, 29 Dec 2023 09:21:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1703870491; x=1704475291; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xKoiaN5Ptx5nvAEn7znQLv6cCCZe9EwH3qBzMCtP9vs=;
        b=oF9sd+cOWhWgo/1AyNvSFN0IstkRRWK6CfG3tx6IDMYboN1/FtisJfSvjg5xc7yIAl
         UKge4w9wPr6wU4noa0KTC00O2UebsFqyN8TbtcVPlpCYevlH1N0c2cW1QKinN8QSt+X1
         t9CeD+2R2noED0oQ8/dQGb/otV3ure9+G5mRqK0/DMlhC6tk7rQoYKLlj83FhdryKhHG
         MynJ7WqZEbWC8UiDV91urQjJkvJvQPikMDlkd/Iq5rMz2/wZKc66wfDSNRbiEhg+9irO
         lF9kwzlNPKMTSoc9exRozWyS4bOc43A/WUaWt4E2wXLf3aOTGb6YAkRE8ONRM83X1+Dp
         6d6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703870491; x=1704475291;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xKoiaN5Ptx5nvAEn7znQLv6cCCZe9EwH3qBzMCtP9vs=;
        b=wubyLTp7O3D+oenCm/K4Gd/Eeft1yFdjxqORtp700L24Jd1d6UMZVw3qXKzP6iel8O
         2Qk6NDgw4fOszcgvcGmLIbaB37lovCWspczpIuVDn/YmzjE59M2NH8ltrROjKyuneqRa
         IRHD56mnjfBrtgROP6VE5jrK+1WJ9eNwvmMkg/iRTjcOX3bHb5DynXK546yMoaMi+e3r
         4WGdcbGH4vxDI6n6hp2J3MopCuUrPhBQeGMmaWzeNQZoCe0XU7BtXXg6bk4+4I/b6qDy
         fab9SREyT6qtCRS/2IKDk2EMw8M+zzQR/rp/v3NhksfNYn7N2vB7c8VUcvQeS/oy5a3m
         IiDQ==
X-Gm-Message-State: AOJu0YwkGOVFFFkospNdXih5JaiiO2OkEV3rWbViS2uqzwuqMsyRdkT8
	M3wf/TdfVrm7NAFChE3FffDDhIJUBRhOTA==
X-Google-Smtp-Source: AGHT+IFuPWC15y3Fys9+ve8/S52v3w4SMiq4MkFREGDbWNkns27R/AxG8CAHo6O41LZvW9O9A3IlZg==
X-Received: by 2002:a17:903:2c9:b0:1d4:61da:1384 with SMTP id s9-20020a17090302c900b001d461da1384mr5475666plk.106.1703870491534;
        Fri, 29 Dec 2023 09:21:31 -0800 (PST)
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id j17-20020a170902c3d100b001d400970b6csm15877720plj.110.2023.12.29.09.21.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Dec 2023 09:21:31 -0800 (PST)
Date: Fri, 29 Dec 2023 09:21:29 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Junxian Huang <huangjunxian6@hisilicon.com>
Cc: <jgg@ziepe.ca>, <leon@kernel.org>, <dsahern@gmail.com>,
 <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
 <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH iproute2-rc 1/2] rdma: Fix core dump when pretty is used
Message-ID: <20231229092129.25a526c4@hermes.local>
In-Reply-To: <20231229065241.554726-2-huangjunxian6@hisilicon.com>
References: <20231229065241.554726-1-huangjunxian6@hisilicon.com>
	<20231229065241.554726-2-huangjunxian6@hisilicon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 29 Dec 2023 14:52:40 +0800
Junxian Huang <huangjunxian6@hisilicon.com> wrote:

> From: Chengchang Tang <tangchengchang@huawei.com>
> 
> There will be a core dump when pretty is used as the JSON object
> hasn't been opened and closed properly.
> 
> Before:
> $ rdma res show qp -jp -dd
> [ {
>     "ifindex": 1,
>     "ifname": "hns_1",
>     "port": 1,
>     "lqpn": 1,
>     "type": "GSI",
>     "state": "RTS",
>     "sq-psn": 0,
>     "comm": "ib_core"
> },
> "drv_sq_wqe_cnt": 128,
> "drv_sq_max_gs": 2,
> "drv_rq_wqe_cnt": 512,
> "drv_rq_max_gs": 1,
> rdma: json_writer.c:130: jsonw_end: Assertion `self->depth > 0' failed.
> Aborted (core dumped)
> 
> After:
> $ rdma res show qp -jp -dd
> [ {
>         "ifindex": 2,
>         "ifname": "hns_2",
>         "port": 1,
>         "lqpn": 1,
>         "type": "GSI",
>         "state": "RTS",
>         "sq-psn": 0,
>         "comm": "ib_core",{
>             "drv_sq_wqe_cnt": 128,
>             "drv_sq_max_gs": 2,
>             "drv_rq_wqe_cnt": 512,
>             "drv_rq_max_gs": 1,
>             "drv_ext_sge_sge_cnt": 256
>         }
>     } ]
> 
> Fixes: 331152752a97 ("rdma: print driver resource attributes")
> Signed-off-by: Chengchang Tang <tangchengchang@huawei.com>
> Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>

This code in rdma seems to be miking json and newline functionality
which creates bug traps.

Also the json should have same effective output in pretty and non-pretty mode.
It looks like since pretty mode add extra object layer, the nesting of {} would be
different.

The conversion to json_print() was done but it isn't using same conventions
as ip or tc.

The correct fix needs to go deeper and hit other things.






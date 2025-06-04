Return-Path: <linux-rdma+bounces-10996-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E19B7ACE2C0
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Jun 2025 19:04:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C01C61883779
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Jun 2025 17:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C3D91F463A;
	Wed,  4 Jun 2025 17:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bpmMt7ik"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A05611F3D58
	for <linux-rdma@vger.kernel.org>; Wed,  4 Jun 2025 17:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749056622; cv=none; b=JZ5m9Im6VslI3akpdALCYZPCMU8E1qt+CVfDqydDNRUeYe2DPffoQR7x9Z1GVbni95ZGq0QgUmJ7rYljij+YtxFHnHHVkpUqYge71UlGkRjAYBiDpwoiesiNopbZ41Ljx9WZjUd1JVL9cpDDDzvGhKjPsj2/aYeYhvsWbTMA2bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749056622; c=relaxed/simple;
	bh=jayrpGQ8EMuNrxluCYCn92f4Z9jqZ5yLz/s/cukRdq8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qDI8e23SqOCaO6WYisRmNXWiWH66wobdunfr+DbgXTQ7ESy5OLuemnPA+4Z88UPXNLPZ4q0TciCjQ1GlvWYCFertnEQVphhMnvXh24t9m8fYEsa7B4GRLx04gRO2rAzua86UwqC7r1q562IQT5yglHaBaRhEpc1zKcf71RS9fLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bpmMt7ik; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749056619;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jayrpGQ8EMuNrxluCYCn92f4Z9jqZ5yLz/s/cukRdq8=;
	b=bpmMt7ik+S8LlV0RjRynQNWU/bEj9cAUes9smFKlQWKQxWICUEyqLO0OEBcNrAUahtxWaC
	fGCx5n2G5tmyI/lDMIlo216shPvRpTfb/aCgfQxcVLE47v0WyFLn9+gb4vb7qzyHi2OCks
	bnhiN6MgJ9tf/4WZltIkKaL+oNMOPhE=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-216-D-89VqJBMtSPE0A95Y8Apw-1; Wed, 04 Jun 2025 13:03:38 -0400
X-MC-Unique: D-89VqJBMtSPE0A95Y8Apw-1
X-Mimecast-MFC-AGG-ID: D-89VqJBMtSPE0A95Y8Apw_1749056617
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-30d8365667cso217601fa.1
        for <linux-rdma@vger.kernel.org>; Wed, 04 Jun 2025 10:03:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749056617; x=1749661417;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jayrpGQ8EMuNrxluCYCn92f4Z9jqZ5yLz/s/cukRdq8=;
        b=UvzRQTfqx9XhGJmot/aol8T0+lqZZc1ICN9MToZKqJvBvY0suYBL/vm8wuLt9TMaTT
         ThDHaD5XhKVRv3aispnexqfdxtQLh51Hcd32Scv5nEbDsJHuHoij+qSbePg/lIwPaIlv
         osaTSjp3Cj5Yp/EU4m1dW4UvI7hjPhtjp1B7KGvLlVJ9jihZRgM5rR8V7KgT+s3aCYom
         Mrzsr8faesogGljt7Q43MdX+YssmSAc+hdAMBGUpUHxb9f3CytZfUid+2yJ1uTSIJPMm
         qYYEv1IlG+gIYfhgAF4sw/uhJXTeEKbYTrkBoG5m8+N5/ADEEWqFXAQMILxzllbjF9P3
         tPig==
X-Forwarded-Encrypted: i=1; AJvYcCXmLdjideLyfeMzc2sDdri+s88OKIMxYfh4zPuyD8xgPx+rY6+iCwbLhzxTAl/f0o8C3D8fk7TVUYiL@vger.kernel.org
X-Gm-Message-State: AOJu0YxmD1Dwbahpgqyybub8tC7Q0IlbMtRmFDdfg+VXvpLI7JaAruZC
	EbIvfYDxXe92BDiGCpjdvV8FDlGOTgb16qWDHjU38NmADPHyDVHlGVYnK0zBRm+SndS+NbSZjxP
	LAnic7RLSyy6p7DSvvFz2yZmDuIg/at5XqEZA4CvlXG6nIjFVCMMRUQkafVmjsJQ=
X-Gm-Gg: ASbGncvhAjpHJOTDbSUCOML1KACzR/+zuWcebe4AkHklFkMxfI/iHq6bX9XiS1ESndI
	47SudRES2HNbxGfdIEfSK5Q6WUh+mueCWiT6dxdhM/6XgFANmB/qiWMAGOsPoodt0lopzpDEvfl
	80hRnkfslHLhV5SA56IRRhcH/o2paGl9A0kxuhEXlhWM9V/uVEMM7mJlcGEDbARi0HSXAU11xWT
	JNlmaupYQHtZCnWC3fkmHWLFAZaWHMJ6ypkCEm0OCr6yBfPg/Cxcw3O/0TazisvCcje1tw/DSG8
	M+f9XBjsvjo4p4nsQSIhiE8ERmD7ucrFP/1Qwr46QEAtprs=
X-Received: by 2002:a2e:a581:0:b0:30b:b908:ce06 with SMTP id 38308e7fff4ca-32ac79599f8mr11789811fa.19.1749056615265;
        Wed, 04 Jun 2025 10:03:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFhvowgSTP9uwRV+BqJt6GC7sN1OE+Dwxjsqttfw8aGqFJyzPj9td+LDCaCRBwp+P5agViq4g==
X-Received: by 2002:a2e:a581:0:b0:30b:b908:ce06 with SMTP id 38308e7fff4ca-32ac79599f8mr11789411fa.19.1749056614743;
        Wed, 04 Jun 2025 10:03:34 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-32a85bd26d7sm22115981fa.106.2025.06.04.10.03.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jun 2025 10:03:34 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 74C7C1AA9173; Wed, 04 Jun 2025 19:03:33 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Byungchul Park <byungchul@sk.com>, willy@infradead.org,
 netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 kernel_team@skhynix.com, kuba@kernel.org, almasrymina@google.com,
 ilias.apalodimas@linaro.org, harry.yoo@oracle.com, hawk@kernel.org,
 akpm@linux-foundation.org, davem@davemloft.net, john.fastabend@gmail.com,
 andrew+netdev@lunn.ch, asml.silence@gmail.com, tariqt@nvidia.com,
 edumazet@google.com, pabeni@redhat.com, saeedm@nvidia.com,
 leon@kernel.org, ast@kernel.org, daniel@iogearbox.net, david@redhat.com,
 lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
 rppt@kernel.org, surenb@google.com, mhocko@suse.com, horms@kernel.org,
 linux-rdma@vger.kernel.org, bpf@vger.kernel.org, vishal.moola@gmail.com
Subject: Re: [RFC v4 10/18] page_pool: rename __page_pool_alloc_pages_slow()
 to __page_pool_alloc_netmems_slow()
In-Reply-To: <20250604025246.61616-11-byungchul@sk.com>
References: <20250604025246.61616-1-byungchul@sk.com>
 <20250604025246.61616-11-byungchul@sk.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Wed, 04 Jun 2025 19:03:33 +0200
Message-ID: <875xhbv3q2.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Byungchul Park <byungchul@sk.com> writes:

> Now that __page_pool_alloc_pages_slow() is for allocating netmem, not
> struct page, rename it to __page_pool_alloc_netmems_slow() to reflect
> what it does.
>
> Signed-off-by: Byungchul Park <byungchul@sk.com>
> Reviewed-by: Mina Almasry <almasrymina@google.com>

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>



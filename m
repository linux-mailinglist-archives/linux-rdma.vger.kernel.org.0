Return-Path: <linux-rdma+bounces-10995-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A162FACE2BB
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Jun 2025 19:04:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5671D3A7AC1
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Jun 2025 17:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6567E1F4262;
	Wed,  4 Jun 2025 17:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R/stcwcY"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA5A51EF39E
	for <linux-rdma@vger.kernel.org>; Wed,  4 Jun 2025 17:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749056595; cv=none; b=ZlTgsg2ArJ5RAPsaQu3o4YS/N+QSgOwwlTnWT7uMeOLAHwE5hcYfFCY901m77SeHoO5H4WEo9bfwmGIRDnO0wSFB/d1VeaW6hfpQXWR3AMpo8oqyGDrSLbxyZkA9sDSX8V6lt08md4vo9TAiUuRfyrc9qK2uVLLgYpAtf9pVNXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749056595; c=relaxed/simple;
	bh=BdQGqhIQcXP7dsPfNkEdiTmcnCKK5h488sLxxJBhbs8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DTu8B5DzUuo79BlX864Y4h2PPf1VxfrWp015uaelQci8uEq/wuAZES5fUQArmFnx4NUS9x1zoRjH9QlqiAnGGNtkQPtRRRSIiYMYIih8NVgYd/Ghv3i1hv96zkWFfT+v1weBo85Q6ch1drJHrG+YWGhDxF1Ux5gIHy96elUofeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R/stcwcY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749056592;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BdQGqhIQcXP7dsPfNkEdiTmcnCKK5h488sLxxJBhbs8=;
	b=R/stcwcY+WZZ4oU/te1L8MbJTeGtVVoIRH9Mpf5ifHCVKlc3AoM+XNyCAlB30RSodpCxCf
	/TDf6BwYPH8p9/pMXu0gAGghCxSz/U8FOhAAG5QdA/6oEqRUEs56CUPMM1N9Thub9YU/aT
	6kUUW4RG0XXn5bQzWJfQgWzYBgla6NI=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-462-YsZ1pWwFMTaGUFcz0qDOcQ-1; Wed, 04 Jun 2025 13:03:09 -0400
X-MC-Unique: YsZ1pWwFMTaGUFcz0qDOcQ-1
X-Mimecast-MFC-AGG-ID: YsZ1pWwFMTaGUFcz0qDOcQ_1749056588
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-ad212166df4so3744766b.0
        for <linux-rdma@vger.kernel.org>; Wed, 04 Jun 2025 10:03:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749056588; x=1749661388;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BdQGqhIQcXP7dsPfNkEdiTmcnCKK5h488sLxxJBhbs8=;
        b=Cuh+4zL6nuHA3f16loC08L+2LVdZKUpQD/40m9eG0MCkbAox0VSxubjS5gGrwl7hBU
         +pXneHn5NZeLsaamLQUtGOO0o4VK0WIhDz04yP9SdqFhNoP20AtkneWLvesg1Jcf5zOQ
         CmalrNQlEY1fMr6t6tNHX+aAdFRQOtSQeSh3f3ZM93DWX0HT1KPrR4MsWelpGlyxM593
         5eYAOQhW/2doKHHmJYYHnCNgVn74AiTGDo38JZaGf382ELElyW2zccnBulZjNn2QID+6
         BNw99D5LIt8ZaQXoyInU3S27dfij5+CvvafXe1gKjJEx1O7pJzn7UAtPOFsvQ9+CboEh
         wCtA==
X-Forwarded-Encrypted: i=1; AJvYcCWKM9rGfmpxpSqMxsIgNd4pVk8GE1OEcya6/Nqksms3yLNVmxvGfFKJwizuDh05btj1PBouovFuTlAK@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9HGFGSFzxo8F8KPMZz2MwZg+teBADlHhLLEfK2Iv3h3tryQx0
	AakFgvsYP/LXOQQ4pkHGOE0YGB9ISvaIPVc+LmBGNdnWPylXGrAloktoMM6dv3x0b3QGqGVV4M1
	jqacM/Rx0r5EzGVIm3DwOndUaB9sJw+L+58BpXvcJpGd2OfKFD+VlGoQmVQPfL/4=
X-Gm-Gg: ASbGncv704IWNgYxOol7xaO2+vi+zPoE6r+tcr0Vlo9u8DaTjqBbBCG/Wqola4U2YrJ
	M8uK4DXlZmXkC9EuS9n2CIj+NNDBUQ3OE42g/4VtRu01s/C9cEJgIF4+PQuaYZ1uAiuVKE15Zln
	3gtnu7aLswTPJ4YutTzDCC4gTAZ7fGcMocYyO13YUmDZBSgOS12QViU0ZAVrVeE9DU1ivkvjD2v
	JFukVwbGVzJTrJtzjjYAKgp1SXi2OvPEgpsrfs/Zz+ByvAppQvRcydQFcQfJRNXGt7RFhUNE9Yg
	AxgNBpEu
X-Received: by 2002:a17:907:3fa6:b0:ad8:8c09:a51a with SMTP id a640c23a62f3a-addf8c30aefmr329524566b.4.1749056587544;
        Wed, 04 Jun 2025 10:03:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEts9xRj/XK3SRKIWyfVZvu6UAgFyS0hpnI7mT5nnKFo1hg8wg/AtXBkeW4IXe7ZmieN8tHNQ==
X-Received: by 2002:a17:907:3fa6:b0:ad8:8c09:a51a with SMTP id a640c23a62f3a-addf8c30aefmr329518466b.4.1749056587038;
        Wed, 04 Jun 2025 10:03:07 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ada5dd045edsm1116783966b.119.2025.06.04.10.03.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jun 2025 10:03:06 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id C8F371AA9171; Wed, 04 Jun 2025 19:03:05 +0200 (CEST)
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
Subject: Re: [RFC v4 06/18] page_pool: rename page_pool_return_page() to
 page_pool_return_netmem()
In-Reply-To: <20250604025246.61616-7-byungchul@sk.com>
References: <20250604025246.61616-1-byungchul@sk.com>
 <20250604025246.61616-7-byungchul@sk.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Wed, 04 Jun 2025 19:03:05 +0200
Message-ID: <878qm7v3qu.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Byungchul Park <byungchul@sk.com> writes:

> Now that page_pool_return_page() is for returning netmem, not struct
> page, rename it to page_pool_return_netmem() to reflect what it does.
>
> Signed-off-by: Byungchul Park <byungchul@sk.com>
> Reviewed-by: Mina Almasry <almasrymina@google.com>

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>



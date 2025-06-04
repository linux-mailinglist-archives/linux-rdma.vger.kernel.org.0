Return-Path: <linux-rdma+bounces-10988-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5444DACE288
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Jun 2025 18:56:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 966E5178B3B
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Jun 2025 16:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ED8B1F9F7A;
	Wed,  4 Jun 2025 16:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e+JY7lRk"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CEEE1EB5C9
	for <linux-rdma@vger.kernel.org>; Wed,  4 Jun 2025 16:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749056127; cv=none; b=DRSS7zScKCfjJS6IGhe5r821UPXArWN4zQJZMvJJ+R3sD59WgnRfkWb2281ZhQyj6Ef6jeq1V+nCaHpCAnmxCh+DUYuFnAhtNQ4do7IHCBWPzXgTV6l5OXgMWt7BmRtWVctXITuwrADYKk/v9j99SpRIdaNJupFa1VDzh0TEm0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749056127; c=relaxed/simple;
	bh=EnhN4jFQnJm7PRT0iNbSmd2PcRrtPdhuDjTVGsmqhS4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oZX1f/pHebqVRhev5rK2Tw4d6O3DmEol9PfBSu9UAxr6U6k+Aj9q1HFqXcEb1z91Sj6eMlVzIfI0zt7u9ToxXQyKN/3oOAok0dqqgOYW5VjBgRZQ+Y7V8ly5MRRrjyE2oIV2sJ9UDV+AuAzOhYVWLOBXTZ51Lh/rP3VyYjRcI1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e+JY7lRk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749056124;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EnhN4jFQnJm7PRT0iNbSmd2PcRrtPdhuDjTVGsmqhS4=;
	b=e+JY7lRkeEFH1WDkkSgZX4cdKUaYz14uMpxSe9UBmezBezA3Yqe9f7NAjfna6JLgne7K6B
	lWXypxLVS7i0Z7/qt4PV5S/aLiEATVaF1QOjSkQhpxI7wWOf8lWFI1XGLfzw1m8QfqqEsN
	0+aesdrky074C/w2gOD6czvCu870s7w=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-310-MH0KdYZTP1mbs2shlXq8DA-1; Wed, 04 Jun 2025 12:55:23 -0400
X-MC-Unique: MH0KdYZTP1mbs2shlXq8DA-1
X-Mimecast-MFC-AGG-ID: MH0KdYZTP1mbs2shlXq8DA_1749056122
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-601f3f35b88so7074934a12.1
        for <linux-rdma@vger.kernel.org>; Wed, 04 Jun 2025 09:55:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749056122; x=1749660922;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EnhN4jFQnJm7PRT0iNbSmd2PcRrtPdhuDjTVGsmqhS4=;
        b=DtnYaXE1mY5wVGZmcIIUQfjYaOXPQcNF2AZ5cBYs7oDL+LV+4lErgSPXLRpzeilRf2
         oAShWAMi64rxO5YzWu7xrgHoSxF47+P8jJIu9CV33lyQ4I46OfkKv1zoj1SghBiGYx8d
         hhFHv2XUmbNQ2mTlM8mbmNWNb8YBu66+Tb6dKe1BQS95APso6+PMj/YzeCgGotC33dpG
         mtYhp21E7yodMFGBLKyiMDCG5sXWY3i3yFH/Mp/CeFo2kKEILG/tDIIcBs4fFjxBbS81
         lfOt8HxzOmAsh7bqBXR+CeCkC/Ux7JSLexsltoekvTWeqdKNvh+UnwlP4qTmIuR3gx7P
         2A1A==
X-Forwarded-Encrypted: i=1; AJvYcCVeEOX51Rmab1O95A/5WRsXIN5Mq6JKt+aN2eBSEp/XhERlMvkb0hNPZ/IZ6BWw+EjNJRPZEGpoGnVU@vger.kernel.org
X-Gm-Message-State: AOJu0YweHS15xpGJnpbyvK2VPWu5zKSMHYYP+QTHPY2btpM42wnzRsaY
	43PICczlzpr2o3rTxNk9EJhWF9l0c7HnS40YlMLmkNXbF77BB5Fi/mY6SxhcQVb30tpB6cGJmtK
	f9AeOJQQDUUNZl8RPn4NxUzIuXk3MjlvpXDGm5SuytTyOZDWpGC8ThT8Ztl5dafs=
X-Gm-Gg: ASbGncvFq9w2qqizl+fdSJ0mau+oZ8VLCy2FYEeKEBhHX2+SanOlbx7q7opcl54Dlge
	0UrF8Bb+xaX7dYwE8PvN4Z082mso1+mb9Mt3kF4q57n0GdSHPEoHeodZxisamKGrc0XNWOqAtBG
	4SSMbBtVumNpt3BkEHxGrt7U19nzGIfahGgRLE1EhpHIVxSHVowNyW9h+HJxBIN1X2Mo2Y9FGaw
	WtbuNoShu6UA4T6o89wMLvn9R5xJT8qeZyEcd/siZPZ8wJsD0zj4Ie5zo5hRDwWJezWgSr8XphO
	F6LMNLmKp6qH4mTqk6E=
X-Received: by 2002:a50:9f8a:0:b0:606:f836:c656 with SMTP id 4fb4d7f45d1cf-606f836d433mr1955678a12.19.1749056122154;
        Wed, 04 Jun 2025 09:55:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF+BjJ2HDUdmh+5/RYHtCz7LviWdEXcE1ZllvhVdcERGB6/R14KgQ+G7LcqUq87LQrs0WIhnw==
X-Received: by 2002:a50:9f8a:0:b0:606:f836:c656 with SMTP id 4fb4d7f45d1cf-606f836d433mr1955643a12.19.1749056121651;
        Wed, 04 Jun 2025 09:55:21 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60566c5a8f1sm9163889a12.20.2025.06.04.09.55.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jun 2025 09:55:21 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 0ABE61AA9160; Wed, 04 Jun 2025 18:55:20 +0200 (CEST)
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
Subject: Re: [RFC v4 09/18] page_pool: rename __page_pool_put_page() to
 __page_pool_put_netmem()
In-Reply-To: <20250604025246.61616-10-byungchul@sk.com>
References: <20250604025246.61616-1-byungchul@sk.com>
 <20250604025246.61616-10-byungchul@sk.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Wed, 04 Jun 2025 18:55:19 +0200
Message-ID: <87sekfv43s.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Byungchul Park <byungchul@sk.com> writes:

> Now that __page_pool_put_page() puts netmem, not struct page, rename it
> to __page_pool_put_netmem() to reflect what it does.
>
> Signed-off-by: Byungchul Park <byungchul@sk.com>
> Reviewed-by: Mina Almasry <almasrymina@google.com>

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>



Return-Path: <linux-rdma+bounces-13340-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69A05B56444
	for <lists+linux-rdma@lfdr.de>; Sun, 14 Sep 2025 04:22:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B24BB189E524
	for <lists+linux-rdma@lfdr.de>; Sun, 14 Sep 2025 02:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D22D42472A4;
	Sun, 14 Sep 2025 02:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XtgqFScy"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E611424501B
	for <linux-rdma@vger.kernel.org>; Sun, 14 Sep 2025 02:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757816572; cv=none; b=Gf/SdpT/brGiDe2o3RmWorMcNm22vMCCfZ9jSIB0iWOZt0fNVA16ceai+z+jhw8MKkILjv+1YxvncaJBVkwP59hXsjdQ9Iv+kvbjxKPA/IzFxYXNOTCkgO9m0q38hmxBbu4vEXCluGkbPNHCbp+av6A7+udY/3cfnDPLsq9tOcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757816572; c=relaxed/simple;
	bh=EX3TyOfBuaXKwQxkn392r7BCMjWDwZpQoG4WIyx3PWI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dmL5CmZ/WLO9gWBAg+PM046rudwgfWnxCMkFYLe7SBwcCManDDf3n12SIeX+yab++WJyGv1zg4DlZxiA0XVjR0OzAAgyk05oQ7uOGF2nydki3BU/pk6XLcYZ8wSrilVlcSY+6eGFYyQNa9MZy3K4JE6e/Ai2NOUOlFHF5U4ZBmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XtgqFScy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757816569;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EX3TyOfBuaXKwQxkn392r7BCMjWDwZpQoG4WIyx3PWI=;
	b=XtgqFScyhPMV4e4PiBwmnzAW0m80TjHOv7Q30y2+5/93j4HlSjZo40SH86o24yZvI1LNon
	sWGrokUpkBbZ81gHzNuxJQsnbgQtnzPVMT3CcrZJVV0L7aWiDoV5cMhc7OsADEprWhjCAK
	DcAXvxOWbV+R8AD5pR+e4drxDptRwhQ=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-MEcBicXtMI2z6EZYqZ2-Gw-1; Sat, 13 Sep 2025 22:22:48 -0400
X-MC-Unique: MEcBicXtMI2z6EZYqZ2-Gw-1
X-Mimecast-MFC-AGG-ID: MEcBicXtMI2z6EZYqZ2-Gw_1757816567
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-56087e8494dso3049420e87.3
        for <linux-rdma@vger.kernel.org>; Sat, 13 Sep 2025 19:22:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757816567; x=1758421367;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EX3TyOfBuaXKwQxkn392r7BCMjWDwZpQoG4WIyx3PWI=;
        b=rVD2AAKJ9OEdUn0oidkBc31AXlJUfNt+qoBc3dB/s1CncJwB6Uon+/omixjaZOuQjt
         BJSOwr0vB1avZs0LB12G7TFC4vsLL5kAqrwHd+ghN32HNuymVJLP83f7Qhhr94x9vFUD
         mWxROHtnVQ8ophWTdDF6KDX0FTXCd5L5WThu3jNrHAaQuysXKLs8zHxYvexj+91FoRqg
         fjFfc0TFYVgljYdim6vgdJuXVV2CBocAB7r534nLW9pqnFhVe9aMbB/iUNaj3qCj9O7F
         bbUaEgxk752hT+ynm9EwgAc6erlDLPgA0pm+9RIy5rodxGlCNpjgMJfCGrH7zZoUuwBO
         Zrwg==
X-Forwarded-Encrypted: i=1; AJvYcCWwqYb7HXtuZGDXIKEndccGnEvEImqbZgGp1BMQZsCbkH1UWO2DNHdQvpZTESb1VVJomXaCcVUEnfnO@vger.kernel.org
X-Gm-Message-State: AOJu0Yze+xHxb4PPmDuwDdqOgTWtZKv346yCAfrEkG4cPfkzvWi5gT2x
	fJ0B6Kmp6xD2DDn1Kcl3sFd4oFg3JFs8xNf4yNIuAtsdHv9+XPCaiUoBplcliMiR9gm94SaYqcT
	r210JRn+oPmu5NXp+A0MJi6L6AOpxyMbANv2i4lf/tifdqpXxriIRkwJDNgIS2YIdvA8b+DC4md
	IXpcwZxcFPRlYfUXLG9byTFKVpfdHXXOYS7/7IKg==
X-Gm-Gg: ASbGncvWICBi0+dxu5yVjKo2HRSsrJzXmrT/9bvbw1qN122xuYakOGHWew5+ME9yF8H
	NunB/MVU/FmvNniGKhOY6b6zm0VbAz1uMSpj5cd56x9iW/Q7M8sWJIUD6M40SK2FIj23Fu420Vj
	Ae+cUX27Ql7eoqLilLXvs8/A==
X-Received: by 2002:a05:6512:61cf:20b0:560:9993:f14d with SMTP id 2adb3069b0e04-5704a3e6909mr2406235e87.3.1757816566878;
        Sat, 13 Sep 2025 19:22:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG6LBuQC+0fECjQxQjn7BzUOWmOXhHvsIC5jjwUVw3z05iv8yLPovYye6qdflldAjCnE1SB/JiNJw+Ng3RRT8o=
X-Received: by 2002:a05:6512:61cf:20b0:560:9993:f14d with SMTP id
 2adb3069b0e04-5704a3e6909mr2406223e87.3.1757816566498; Sat, 13 Sep 2025
 19:22:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250913062810.11141-1-litian@redhat.com> <bacbeaf2-104f-4da5-a66b-b8aee2b2de12@lunn.ch>
In-Reply-To: <bacbeaf2-104f-4da5-a66b-b8aee2b2de12@lunn.ch>
From: Li Tian <litian@redhat.com>
Date: Sun, 14 Sep 2025 10:22:35 +0800
X-Gm-Features: AS18NWARZWkoG_VR78fDtIJydZ_R8xlJD5gNpW5l3SKmCv3wXuhvflXEKdZ8Jf8
Message-ID: <CAHhBTWvcd45s5P-TfKBVzHy00jofbgoWtX+z3Uaj+5ZEBTNLfQ@mail.gmail.com>
Subject: Re: [PATCH net] net/mlx5: report duplex full when speed is known
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>, 
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
	linux-rdma@vger.kernel.org, Haiyang Zhang <haiyangz@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 13, 2025 at 10:12=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote=
:

> I'm confused with your commit message. You say DUPLEX used to be
> reported as Full if the speed is known. How does c268ca6087f55 change
> this?

Because in some circumstances like Azure, mlx5e_port_ptys2speed (now
mlx5_port_ptys2info) does not return a speed. And thus it relies on
data_rate_oper. It reads to me as long as there's no issue acquiring
the speed duplex should be set to full.

> You don't say in the commit message. Why is Half duplex
> important to this fix? I don't see Half anywhere in the code.

It does not return half duplex at all. It would be unknown. I'm just
saying that half duplex shouldn't exist in modern Mellanox 5.

> Also, what sort of problems do you see with duplex unknown?

There were reports of RHEL seeing duplex unknown in ethtool
on Azure Mellanox 5. The intention is to fix this.

Thanks for reviewing.

Li Tian



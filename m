Return-Path: <linux-rdma+bounces-3049-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D2E4B90378C
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Jun 2024 11:12:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AFEC1B24B66
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Jun 2024 09:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77593173321;
	Tue, 11 Jun 2024 09:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mjaxns2Z"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B39B6176244
	for <linux-rdma@vger.kernel.org>; Tue, 11 Jun 2024 09:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718096981; cv=none; b=k0ZnamiY0CqLGEntkCmwkqMVEfzW/j/qrgLO+AZcg7pNKtAV5rkjj/i6YQo+zMwWoGEeK8gX9hcRw5PZ1zHbunYuwGcMBBoh3+NZEAvedYlbOWTkrJk/ITsiSDML6fStMO4XuK9HiyXW8+QI3rMFWKV0Izz00nirmh0Y3IdCWYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718096981; c=relaxed/simple;
	bh=i0S4WNj+dZaz3hdz9rhQaN2ahipED7/FlbM3wn5jydM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LWcB7LMODkVL+dPFmA7OMZ//fPfYbqbX1ltwewSnXM+tnnla4Ldcy3U415UMDRnktLxMXYmBk/fqKGMvu+urOgKtDgDi27pbl+7TIvXRPOYg7Qw3dzafwIKjtCBQ5cB+f65Kzequg/cGYHE8NDJbSXzXiWeJg0d2wLb7TRwg/3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Mjaxns2Z; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718096978;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wJ6NmEpm203v83OTy1RMNtAkzbu+fQMhPGN0G4SJVPY=;
	b=Mjaxns2ZIaRszze7VkyY1v67WCzdRvvbCn9vXexzoUw3TTyb13LI6UMj2jTz4PLlauWHDk
	G1hJmQbha0TUHlPwfOVf3fWXldibxVgX31VtePXwvWD2xpR2JPRWmcN5NMqAQbVz/NL+sM
	BeWJ3lo1LfuuK7tMHVuweAUbP3ycrA0=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-646-AcTITdEfPMSTbqJL8jFleQ-1; Tue, 11 Jun 2024 05:09:37 -0400
X-MC-Unique: AcTITdEfPMSTbqJL8jFleQ-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2ebd7556679so24551161fa.1
        for <linux-rdma@vger.kernel.org>; Tue, 11 Jun 2024 02:09:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718096975; x=1718701775;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wJ6NmEpm203v83OTy1RMNtAkzbu+fQMhPGN0G4SJVPY=;
        b=ih62BWCPDO0YXKOF5dX57EWa51DGmeHlsYJI8x+JUrogj7VAQNKpWdhlm5EBs3kSHG
         uY9tYHQbNKCCGCErjQ64t0qntTxh27eWJmQSjBKu4Yd6UMhT9CEvfuUo/t4Gn2p5LXUu
         6casLcilc5E9cpeiuZ+BMD/WoF7dtD1ieRXXSOUypigwLFYxTRq7ZMP4uUXbzKiI7zFc
         +WxvYjixxtC/Aarba4tl1sbOMO3tSblBRU0kNsJane279SQ1frN+3q/T+FoLgnG6RAoo
         vdnPb7cVdrGKiANIi6dPG7Z+UjgmgpbeL5p1ZJU/Xd81ddKNKEU8kmuyUl+dzWHM8r4+
         dJVA==
X-Forwarded-Encrypted: i=1; AJvYcCXwKS6rd3rchcz3hLZKHkjBFB97GoK7P8j5jgk0bGO0TT1jY5qPhnG1d1oPFji6rX5K3dYGgtTXxG3yS85CPdsPLT6OYeyKcLfgdA==
X-Gm-Message-State: AOJu0YwWy023+rbH7f8MyLyoyn/1Bxjm9quwGj1a55xnz+Wqai8/o2hZ
	+RKq3/QQ4Lez6Ve3tVqKiBk0OQV5v3YvrlcPe7QrxTFeul8pdy+uBtgSejQCDUYnmmtzKT26quY
	J+BOnx8njAg8ZaJiWXovVFIWVLHX9eRrpRzrZWpJCPUUqW6lNwRZleZlNsv8=
X-Received: by 2002:a2e:8004:0:b0:2eb:f5ec:5ad6 with SMTP id 38308e7fff4ca-2ebf5ec6fb4mr4791391fa.0.1718096975472;
        Tue, 11 Jun 2024 02:09:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH7wwWojKAzRVTdY5Y8CDndML4n5EP/ZdMfOeDFja/TJ2/4XahWfKaFctCxnoWRR7nsots0ag==
X-Received: by 2002:a2e:8004:0:b0:2eb:f5ec:5ad6 with SMTP id 38308e7fff4ca-2ebf5ec6fb4mr4791061fa.0.1718096974914;
        Tue, 11 Jun 2024 02:09:34 -0700 (PDT)
Received: from localhost (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4218193b0c0sm84032445e9.31.2024.06.11.02.09.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 02:09:34 -0700 (PDT)
Date: Tue, 11 Jun 2024 11:09:33 +0200
From: Davide Caratti <dcaratti@redhat.com>
To: =?iso-8859-1?Q?Asbj=F8rn_Sloth_T=F8nnesen?= <ast@fiberby.net>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Edward Cree <ecree.xilinx@gmail.com>,
	Martin Habets <habetsm.xilinx@gmail.com>, linux-net-drivers@amd.com,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
	linux-rdma@vger.kernel.org,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	intel-wired-lan@lists.osuosl.org,
	Louis Peens <louis.peens@corigine.com>, oss-drivers@corigine.com,
	linux-kernel@vger.kernel.org, i.maximets@ovn.org
Subject: Re: [PATCH net-next 0/5] net: flower: validate encapsulation control
 flags
Message-ID: <ZmgUTZPFKk1pNxqR@dcaratti.users.ipa.redhat.com>
References: <20240609173358.193178-1-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240609173358.193178-1-ast@fiberby.net>

On Sun, Jun 09, 2024 at 05:33:50PM +0000, Asbjørn Sloth Tønnesen wrote:
> Now that all drivers properly rejects unsupported flower control flags
> used with FLOW_DISSECTOR_KEY_CONTROL, then time has come to add similar
> checks to the drivers supporting FLOW_DISSECTOR_KEY_ENC_CONTROL.
> 
> There are currently just 4 drivers supporting this key, and
> 3 of those currently doesn't validate encapsulated control flags.
> 
> Encapsulation control flags may currently be unused, but they should
> still be validated by the drivers, so that drivers will properly
> reject any new flags when they are introduced.
> 
> This series adds some helper functions, and implements them in all
> 4 drivers.
>

Reviewed-by: Davide Caratti <dcaratti@redhat.com>



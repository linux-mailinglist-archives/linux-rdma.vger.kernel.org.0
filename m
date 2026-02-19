Return-Path: <linux-rdma+bounces-17016-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mP1wHGogl2kJvAIAu9opvQ
	(envelope-from <linux-rdma+bounces-17016-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Feb 2026 15:38:34 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 61EC215FA2A
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Feb 2026 15:38:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1AF5C3064920
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Feb 2026 14:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6D3D2F83B7;
	Thu, 19 Feb 2026 14:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UCVgJs1H";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="LiX+ROzB"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 670E033FE00
	for <linux-rdma@vger.kernel.org>; Thu, 19 Feb 2026 14:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771511721; cv=pass; b=H9zZ+BZ0VUh/KeHgm/R2AwGQDmAjy6uEZ+67nv7CZW1r3zNtZlPKgC6wA4B1L1zyp0VOQ5raW5Crvx1wQLMECQbSj1I9pianRrQpo19eFzXD/8oAAN7Il3DrTYjtCeF4iNdtiPrlXLynZtgJvzSzOoS3QNLhA35hx5C2u0btFuU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771511721; c=relaxed/simple;
	bh=VS5MpAECM0VVXiBFVjd8qc3AEbApFHruj64/cu2gaHY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=iXW+Ak4XXMbQ2DVfbYFEAlV3cfKwMWev9gDUrA4RmX95DiuLTqssy7IHVl9D9VI3dfgvC2XZpcR7yHyHHIRdzI/5ZREXFweiSmU9K42n2PCFqq/DtF5a4Wg70EcVZIkKmNJHG7nfW+YVxSCGIl6XAVrtWIBdMy98cK+Rq1rrh5I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UCVgJs1H; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=LiX+ROzB; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771511719;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VS5MpAECM0VVXiBFVjd8qc3AEbApFHruj64/cu2gaHY=;
	b=UCVgJs1HoZorSxw3zDkdlY4aYP7skwdcgTQqOL59RSdqX2H5qYzUOSp7/wNvs7nHZaqqEX
	RzIf+oVxYI1O7iJS382lSk2jwTtMkN6EzvZoVbptWNqkgGG8fC7RqPAvHsFJSlW7BfR8Ft
	ciOQG3eAdDPxhGJs0Z0gb8lLux54N8Y=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-39-5FDhh1IRNn6rQrewZYj6EA-1; Thu, 19 Feb 2026 09:35:17 -0500
X-MC-Unique: 5FDhh1IRNn6rQrewZYj6EA-1
X-Mimecast-MFC-AGG-ID: 5FDhh1IRNn6rQrewZYj6EA_1771511715
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-7949310b90cso18122087b3.2
        for <linux-rdma@vger.kernel.org>; Thu, 19 Feb 2026 06:35:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771511715; cv=none;
        d=google.com; s=arc-20240605;
        b=Yw+RSVYa3PkcgRlwZK4JXLFKL0Yanpu+jYFNFlqalVgzf2U8ZaeBs6L3uNEaUGq3y6
         AlAgPATu6EKNaTgH3ZK5PwM32IqlVLDGMWEc6b/Qgc+6pRcrqF9YtAKXo+yZ5WyEaB1H
         pgH9LIQv8MKMMMr9+tnEinIiU6q6vOb9jlLZu4V46vmj3i8MrfYyJHPVhHaWuRskKF2B
         3Bh0aAPsnX4NOs94lsK0ydNGFPAWvfwv3RcOg0WfIwEexbx1ZaXhCx/ddE3qsyi8uLeP
         LMxSLZOQd1k89b3eAE6O5tWKpdGeF4fLfzHNpKkd0ks87fLvsg92QM0Gz20G6ZYMGyiL
         upuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :dkim-signature;
        bh=VS5MpAECM0VVXiBFVjd8qc3AEbApFHruj64/cu2gaHY=;
        fh=RAuIdJRL5K9zqXpWjjkdWz4idt2YWgLQWAauChMxKr4=;
        b=LjY5PLUxWkf0TWPeJhzvgAadyi+FhXJggNP0sP+6HAqWjFjusm0+eudEgBZ5G26SBn
         FJYpg66SEcOn07HeZG18O/bFGzaw2P8c6pJpYLvqlbL46Ele/jql4QBJiPno4MxUAj1r
         CVA7blfq0T6gh0Xl68GeZXYFTXru2JU2ZDQ4X9cnSdKkUIw8uYciY2KCtjZjemB000nt
         avDrlnZX4gknPr7CPimfv0R+hDJBPdpMfTRJuslwbGd8LLJvybrrzC2Ew0YC6N1yEzqW
         JFtsK0y9zPmFCciaJbBYulkP6fWt82b0UyB0BgbT0TMzo9ZX53Jqb7azDDKh7e2QM6V9
         3hnA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1771511715; x=1772116515; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VS5MpAECM0VVXiBFVjd8qc3AEbApFHruj64/cu2gaHY=;
        b=LiX+ROzBg8v68XYnnmkKEkgos2FcChDT3BI687HpMANuVWpM2WvCIZoG4X5O3iF+aW
         bggjw8KIGKXc2PavzBrE0I7aRnVxiU/LCfTbqudbsogPuPXrfpv+kHQcSn3XGjaKpmZk
         9ArhzZ76cuw4U6mPHgUpMO+b/eRelXOGQgDqqZ3JVyOQmCp1ciFdv7Y/an6YcJc3GBbQ
         HcYsCCOf+TYVlN+SxlA524CTRybrff7lSYA9Gb8vz5klUwJUbeXASF057D+v8T53jJth
         Bo6gZKEdj1NbpCnQ3to8iKm/oc9hC9i+uW+BWpZ5cFECJ3I0SY2cX9eEUXi7ikqe66U9
         Lv9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771511715; x=1772116515;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VS5MpAECM0VVXiBFVjd8qc3AEbApFHruj64/cu2gaHY=;
        b=uU6zbiykfiKo0X2oVrQjKvEi66eH5pZizRpZDOROGKCUL5a1vtIREP1W4E0P2ydRyA
         esaq7HwT6nbUUc2bspHOZsVujBh1y2kiUkeb9dFI4lUsKfpJirh51Rsg68pBpAuX9WNQ
         Csc8ZJyIoz88CJ35XIEA8yNojrf4BE2a4qXH2GUw2+rJqiOVOibXZ3UvEhcHybOKFtIv
         i+C6Y2nPJ15M9v3MLzObuzYvhtcMrUn4ZhV4/9IESC5mBT2aoHaQFGdzTp//sPGkp8yg
         rRqk1arUAxeQYdXoWMf+fVe4Ok0TDDJpVWc6Atzcwi8fonwIcbfUSmS7FoYQ+HPrfu4R
         8ptw==
X-Forwarded-Encrypted: i=1; AJvYcCXFFT7FMgeb7IzO0hbk57N//gLj+db1LYN0P7akTQNrJ+hAuinyPaliLQsx3O0DNh9dUIKPuwQCFL36@vger.kernel.org
X-Gm-Message-State: AOJu0Yx74lwd9kkjqxhrtHTvOKV3VzYAm9mKheUR4JN4fbAbornVrkr5
	HmEK9M6LJNzQBVW2ZFJ+QYNOOljBS2Z1P1tJVX0v8tY/RnDS61W8yeXB0zNr6u2aP7NBpCYCbPG
	WvaABe/ILIpb3ub9HJwSNmNEGTirwrfCxKQ1u8hVjzbkmFV2lK+EhR5j2nnsmt3QHuYtHdxSoGm
	u3NJDXWqL9MEmBSTDVax8Z28DJ1LZFhd7gfuyYRg==
X-Gm-Gg: AZuq6aL+cwFDwkek+Qf81fdpTtpM2J0ymRD+/xafcZIdNsulWu40QyGGWtQXVoZBEvE
	zXXdQ9kEj4NFszEpBJLy3QymPsRzB/FKvsTpD7v5DVu8Mx+JZP/Nao3vrNRplFm2GyMDVPWAzTv
	p6liNWDN29tb0iL1OmDSuINMxWuPCbv7/0jkEdniGbAwHR8hU/9B90QBrQckBiB+ZYH0jO50cSv
	809fXY=
X-Received: by 2002:a05:690c:6111:b0:798:27f:8839 with SMTP id 00721157ae682-798027f88edmr27293367b3.49.1771511715376;
        Thu, 19 Feb 2026 06:35:15 -0800 (PST)
X-Received: by 2002:a05:690c:6111:b0:798:27f:8839 with SMTP id
 00721157ae682-798027f88edmr27293087b3.49.1771511714813; Thu, 19 Feb 2026
 06:35:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260216085143.40242-1-chia-yu.chang@nokia-bell-labs.com> <20260216085143.40242-3-chia-yu.chang@nokia-bell-labs.com>
In-Reply-To: <20260216085143.40242-3-chia-yu.chang@nokia-bell-labs.com>
From: Paolo Abeni <pabeni@redhat.com>
Date: Thu, 19 Feb 2026 15:35:03 +0100
X-Gm-Features: AaiRm51Yk51MtFkLMzzNm9UI6iqJ3T9b_dxDZQ4oQ-vg-XKrl3rs7xeprCakWg8
Message-ID: <CAF6piCLzyKzGFHF8BNByg-aJD_E6-oOt8RZ9gBO5C3-ANyDx0Q@mail.gmail.com>
Subject: Re: [PATCH v3 net 2/3] net: mlx5e: fix CWR handling in drivers to
 preserve ACE signal
To: chia-yu.chang@nokia-bell-labs.com, linyunsheng@huawei.com, 
	andrew+netdev@lunn.ch, parav@nvidia.com, jasowang@redhat.com, mst@redhat.com, 
	shenjian15@huawei.com, salil.mehta@huawei.com, shaojijie@huawei.com, 
	saeedm@nvidia.com, tariqt@nvidia.com, mbloch@nvidia.com, leonro@nvidia.com, 
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, horms@kernel.org, ij@kernel.org, 
	ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com, 
	g.white@cablelabs.com, ingemar.s.johansson@ericsson.com, 
	mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at, 
	Jason_Livingood@comcast.com, vidhi_goel@apple.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17016-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[nokia-bell-labs.com,huawei.com,lunn.ch,nvidia.com,redhat.com,vger.kernel.org,davemloft.net,google.com,kernel.org,cablelabs.com,ericsson.com,apple.com,gmx.at,comcast.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.997];
	RCPT_COUNT_TWELVE(0.00)[29];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 61EC215FA2A
X-Rspamd-Action: no action

On 2/16/26 9:51 AM, chia-yu.chang@nokia-bell-labs.com wrote:
> From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
>
> Currently, mlx5 Rx paths use SKB_GSO_TCP_ECN flag when a TCP segment
> with the CWR flag set. This is wrong because SKB_GSO_TCP_ECN is only
> valid for RFC3168 ECN on Tx, and using it on Rx allows RFC3168 ECN
> offload to clear the CWR flag. As a result, incoming TCP segments
> may lose their ACE signal integrity required for AccECN (RFC9768),
> especially when the packet is forwarded and later re-segmented by GSO.
>
> Fix this by setting SKB_GSO_TCP_ACCECN for any Rx segment with the CWR
> flag set. SKB_GSO_TCP_ACCECN ensure that RFC3168 ECN offload will
> not clear the CWR flag, therefore preserving the ACE signal.
>
> Fixes: 92552d3abd329 ("net/mlx5e: HW_GRO cqe handler implementation")
>

No empty line after the fixes tag (both here and in the next patch).

/P



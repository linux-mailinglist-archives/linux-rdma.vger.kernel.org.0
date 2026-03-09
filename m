Return-Path: <linux-rdma+bounces-17749-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eOsfE/J5rmm2FAIAu9opvQ
	(envelope-from <linux-rdma+bounces-17749-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 09 Mar 2026 08:42:42 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9944F234ED3
	for <lists+linux-rdma@lfdr.de>; Mon, 09 Mar 2026 08:42:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3419C3016497
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Mar 2026 07:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A069368967;
	Mon,  9 Mar 2026 07:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ED92KBPn"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D58368954
	for <linux-rdma@vger.kernel.org>; Mon,  9 Mar 2026 07:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773042126; cv=pass; b=S1HhRAM+ZjEWDdh8bZF86OdJr/aPncytHAsxjUqfa++ZeTZqM1rfZpSRNsVL94RV/ZNUTOYafWf8zah5byqeZOFFS2lVvp1rxwiHCWgEQRzActgDp2goFo/wSd5vIzxY3uOSQUsoI4saCWFzhgrUW1xEArTv3OlVpeEz6flZ+C8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773042126; c=relaxed/simple;
	bh=20pLA8aTnuOverELLa+xwmHWkebI08PbsXBoj9i3xHg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cahdPa1YkSNnJqc4It8SvqiV81zRiUqXLz5Kfnzq5CiNq6P83JspiwNsftKqXp8lyBVe/1zIwZ2uInfy75l7pu1vZfPjdAbYNIyRPgcAdSSLNoGFM1SzpkJoKxvn6tsr1iDAvcWO8kDubAojTY/p0Iz+gJBD5GckEJxZJitWRo4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ED92KBPn; arc=pass smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5a0fc5e2c59so7029385e87.1
        for <linux-rdma@vger.kernel.org>; Mon, 09 Mar 2026 00:42:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773042123; cv=none;
        d=google.com; s=arc-20240605;
        b=ZGvuXN9PL2XQ5QSSMtLScyTfWGSE5O721OEJ4gKIw8RaN7sl+05Txhje9HzkgLuxEa
         i7TC4RhMP8ugS7l82JnY36Y42h5F7Br+lQ466N2kwSG4DHpltkU2PXZPy+eSUM4PjlYe
         71yoak5tYoLDPLRjlIBT/pFt0HYfmNFYpABCzqE51TkDKyRP62T3Gab87eAz1bqWHeqx
         u9afipWIpUoaMFvDWqJepwJN0odFGE/GIF53U5QzxVmzRM6WViVn4s11qAwqvsv94o5f
         15fVKrSBmi3fiaQwDmgkXKVqCWrCm1vPd6ewoEjTMubQdWrmG1bGKTv4y9PDYoSGTMiI
         cqEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EVM3Gu0Ll66tTIoaltis39QlEHeXC7rZv0JIG0ec43M=;
        fh=jJBNSu/0NMusNKGgCL6whis+WV6eOznM4pvOpWdadtQ=;
        b=Lw5mkvnAUvFhDkEZI/06/xyG90V9733jLfp2wK9M7OhTWvUJoyVrtgqVfGf+8YuPUA
         xdaDXNnAMhsS2YlUEHtH2oSnBAEXkbedExGZArB4fDyK3Sm0nCFz1FbmrJ1kAwLWS3s/
         YZ62IPifcjLPSFJSfoGUZgwGVKeqc+YDGNpBbhmuI5k8v4CWjTgLCwjgEkv5Dtb17dxs
         VYINkOj7xCHsphoaA/N+eg3zZODvacBY7NvJFtJ5QThXwt0OoL0zPF/BEO5HMIIJcYJI
         //IQtuYB6xzDp5tiGdrEnSSZWXEa7Lo/HOrsRk6jcTuQmjmOQMuv9SYoxdI7C7XHntr5
         Cmzg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1773042123; x=1773646923; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EVM3Gu0Ll66tTIoaltis39QlEHeXC7rZv0JIG0ec43M=;
        b=ED92KBPnylWjovXaJ+pt8soBEVb4l1WO/m3Tyr6CgZ1GcuPtocPf16gDmd2C6w1ttZ
         h9afQtrKK6KuRsbKM0UfhLHn81EmdbdSzjI/rvs2EoBzLNknuNG0fsl1Hzm27N6nlYbu
         U79eZqOp2MkzxTYfisSnEeOIy0mCBajHvRCkfEC5eF42biIcH3Wjgy4uvNpYNQD1x7h8
         7ueIqiQZyZoIJN5VrW/0U/DJYQHcTWu9L4SrVXaayc0hQxbw+Gr4/lt7JztJFFPQp/2B
         SLlzC3e3BZ3ACWWsRSBqoQnDt2uO23J5AzVE9IFVVlcsjNlua/GAvh1hasX3UrS+vUz+
         3oog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773042123; x=1773646923;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EVM3Gu0Ll66tTIoaltis39QlEHeXC7rZv0JIG0ec43M=;
        b=pyF4G/cpnU9SyvuArAmMOjVaK58rlggGbXpkwehr7RX8OpIsUfGtAIuUMCszloD+kN
         GMZUxNtJzevOElAaAxmO/OlIMQtOTnEeKB17Omcr+BgVeSeTn9VD4omovO090PQD2WLX
         B0E5jM8L79n0fzvLPFEeeLZOfFFSyL6O3sUTPp3ZzxEawpEu6rIW5vsyp2wUOaAZ0O4b
         WkHr/OiD0Jm3yvp1vQOCH1Hjp4A1GUOEVcwiJE8h9CeGzcwTGYdCUNSoFhuR6+qHr2Cq
         dv6Q+qVjtqI3qbDGjCZtjcEdwE38sdLh32Xk25C8nyORC7+4lP//+2Qn4PH6JkVKf89F
         TglA==
X-Forwarded-Encrypted: i=1; AJvYcCUiWfaErGUbBbcn39LatWC9wICU+7AzVlQd9eDzLon05A5E04QpYIn4Fpi6Ni62UpGAUcqrc7TxIScp@vger.kernel.org
X-Gm-Message-State: AOJu0YzUKtCtpWrTonOZh3fqiFc6xh8pMWxa+gr0OjHvMsn8kTp/qPDk
	8eCKbo4JomHNXUfNs5ny+XP2nWycBCIIVnfYNLfeWsNYoQIINv45fHQT582LXde8Xf+kBDAiucv
	89lbiynEum637ATgfmAjFWH7MWOibQ6RYwZ+6dbBLXw==
X-Gm-Gg: ATEYQzzavkrXMYZ3f5DUmCeZqB65EW78WTXrmr1CJD0g94TVSVsUsNrGoGho5xgdkNA
	6oRbqoHam7bPuTPcvWAr2XPoz8ASM3yHlGvJwjdEu+mJdHP927N40SoMN4hlFGXljXMk3WL24tX
	1k+CyBTBWXV2ksSHjBSvXj2jHRGDSFgRGlsjYiYSJMXXJJtTl4UrjJ9lNfnpqaQOMxWTbnNDoIi
	LcoNjEUwIo+FHhaq0YGfRB8R4AxgXglV0MMKQBBz4VMKsZJ6p5lgNkAFZ5ed1PEpkIfgSlVUZqj
	0tweulo4vomnFk8jAmLflPBBXLmoP59ixWfA4wAY
X-Received: by 2002:a05:6512:3b9d:b0:5a1:2e83:a7f1 with SMTP id
 2adb3069b0e04-5a13ccf293emr3370494e87.23.1773042122719; Mon, 09 Mar 2026
 00:42:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260305154117.326472-1-marco.crivellari@suse.com> <177296790644.1461936.14617612915039201170.b4-ty@kernel.org>
In-Reply-To: <177296790644.1461936.14617612915039201170.b4-ty@kernel.org>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Mon, 9 Mar 2026 08:41:51 +0100
X-Gm-Features: AaiRm500eP8uwFhjj736sTHcJb7xzGS5l_C31OT4qWoFqKWBMRt2V3Q2vVRg0Vo
Message-ID: <CAAofZF7_yKUFUnCqOgt7AapCTepFzvoegry9+px4x9gbFVL08Q@mail.gmail.com>
Subject: Re: [PATCH] RDMA/rtrs: add WQ_PERCPU to alloc_workqueue users
To: Leon Romanovsky <leon@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Michal Hocko <mhocko@suse.com>, "Md . Haris Iqbal" <haris.iqbal@ionos.com>, 
	Jack Wang <jinpu.wang@ionos.com>, Jason Gunthorpe <jgg@ziepe.ca>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 9944F234ED3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,gmail.com,linutronix.de,suse.com,ionos.com,ziepe.ca];
	TAGGED_FROM(0.00)[bounces-17749-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[marco.crivellari@suse.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.981];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mail.gmail.com:mid,suse.com:dkim]
X-Rspamd-Action: no action

On Sun, Mar 8, 2026 at 12:05=E2=80=AFPM Leon Romanovsky <leon@kernel.org> w=
rote:
> [...]
> Applied, thanks!
>
> [1/1] RDMA/rtrs: add WQ_PERCPU to alloc_workqueue users
>       https://git.kernel.org/rdma/rdma/c/8db7b7d9ba170e
>

Many thanks!

--=20

Marco Crivellari

L3 Support Engineer


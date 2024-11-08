Return-Path: <linux-rdma+bounces-5878-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7D2D9C2684
	for <lists+linux-rdma@lfdr.de>; Fri,  8 Nov 2024 21:26:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9ED731F22F52
	for <lists+linux-rdma@lfdr.de>; Fri,  8 Nov 2024 20:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51E8420B7EA;
	Fri,  8 Nov 2024 20:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eqgg0yN0"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84BF31F26D9;
	Fri,  8 Nov 2024 20:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731097557; cv=none; b=DclHSQOvn9AKWch8lbxH78y+LD1vAGUG6lBiYVMsoctMZ6uo1E7lwuQJXq+cddvm2F2jS+bU+d0FLWLEhatROMXK5e7hxndN3GcheUiUKF1JxRTTKCLdz6fdSEYNFWoep1ikLhpLMrcwM8twV5NmfNSHugtn8ExIYJCZO48suYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731097557; c=relaxed/simple;
	bh=EwuR0aEZqAZbI/6IsUs5eyGt9WzC2ruGQlQLKWSC90Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=P3TanqqtkiLGwvWccU8MFxlZLL9T/RsmWcRPVHLnDgArAx2egh0vKaJgjsaxMeTJW8J2UBf2Dr9AoCxYtts6EtVYyx29hZMr7of5fBDw9WdBHgAYy9kaf8fvzy5a6IKlzhVt+D3EBnj4RkxsJ+pVO11f4uPXhPiKXyrnzpypQSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eqgg0yN0; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-723f37dd76cso2738740b3a.0;
        Fri, 08 Nov 2024 12:25:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731097555; x=1731702355; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ziC/Yq61LN2QkFiWm1kDqgTQsLk/e+GZCQ9Xzo2PVrg=;
        b=eqgg0yN00miMkTGeuWVh+6utVnlHGb1ofEagTZzxcSdbJUh0ycvWUadbl9sEtQNfZU
         xeVLiRNMYM0vlLAMk4WyDnlwY67h/wJVMSan1r3uPPiLWJ/3B9zLundQZOXyVjONCYY0
         yjc7D+XPe5Y1BJBBThqq8UdfSxAxLH25vaU3ONyQAv50vifKaR1ycZ7os5dwOZqll9uu
         3rlwLWG/aOMHDROJWyXGmoM5do8AySK6erAJhXe94MjouIRWgFEClhwHckcnbfIPJ+9h
         OxVzIAJp+bp1MPan8foQ7WnqIwGmQOkRMjVp8wXmQFNwnaCng+wArNIEXI5XKIAIkqQW
         YULQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731097555; x=1731702355;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ziC/Yq61LN2QkFiWm1kDqgTQsLk/e+GZCQ9Xzo2PVrg=;
        b=onvGGl8RybmP+miQ6NRa4LJw4AAwk7OEp6SCnESSwEYqk0xP4MqJ72cqZCPIqz9yMZ
         C1O9yR9qdTtKIp2kcu+3kSRVpW+Wvszvwj2RB4VLAPCp7FhCD7RYgSDbKYkU0jZ3v1TN
         qK3+ClGmZeQHZ2b7gm2M0S1/P/3tymyixPP1/BxP6C+SrQEHRmhH8eD2JSCFzxk7NMmP
         WnIF7Gij6gl7AmGNveOA8h3qTOppr4UrPNZYfLrsldPW6bds+NalnHZGVO/5U0bgLSW8
         O2K/AXcfPSPS3yL6jTD8ozhy01TvDT+EakwqOV+OpSoGd1HFNX20PuT61QQMbJSIAWYA
         LH3g==
X-Forwarded-Encrypted: i=1; AJvYcCUrsUF7SvsoIlZQgkWH5NUcmDYpK4oVH3mjMKX+FAQeGV6cHJ9wY5HSqy5/Kl5pPybib+/Rg5/Vgf0=@vger.kernel.org, AJvYcCWFZ3m9gG5E+LlUILtOlZ+w9KNsYoAsGYF55PlKOmgusIs6ZDe8+uim+DMUdWZvfFStQUOeYn0r@vger.kernel.org, AJvYcCWhCGQoOu0Ai14IRdmbquqVBv0Jj3vk/IySiqM5wuDjMS7Y0DmvLliKR2OoHCWTY8OIhZCG3ENuUUC4DFDF@vger.kernel.org, AJvYcCXDtJEDk/UHeuc0Y9c/2ZHihDIPgF/lW6kCD1PsrkqvC0UpjJgu0rOagap9IHcXEK2AxuSQSyofnq1WfQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzJ5HBi7g91VSmejDvaJS6yqxCVrjVIxjdMkpcn6eitLfqdAd1E
	ik1b1CqjOrES6Rj65UheM8Vm1XmZ6IOUfUwv4SkUQYhkg+/jaTKK
X-Google-Smtp-Source: AGHT+IFzz8Lbq/N+oEHpfPZUIZbcUUGi+YneJibJoBrUZTYSicjrrJP7xbTOlSK+DN7/o1E/TruelQ==
X-Received: by 2002:a05:6a00:3399:b0:71e:7d52:fa8c with SMTP id d2e1a72fcca58-7241338b59fmr5742858b3a.22.1731097554716;
        Fri, 08 Nov 2024 12:25:54 -0800 (PST)
Received: from 1337.tail8aa098.ts.net (ms-studentunix-nat0.cs.ucalgary.ca. [136.159.16.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724078a7ef5sm4342095b3a.63.2024.11.08.12.25.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 12:25:54 -0800 (PST)
From: Abhinav Saxena <xandfury@gmail.com>
To: linux-kernel-mentees@lists.linuxfoundation.org,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	rds-devel@oss.oracle.com
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Allison Henderson <allison.henderson@oracle.com>,
	Russell King <linux@armlinux.org.uk>,
	Dragos Tatulea <dtatulea@nvidia.com>,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>,
	Abhinav Saxena <xandfury@gmail.com>
Subject: [PATCH 2/2] docs: net: Fix sfp-phylink whitespace
Date: Fri,  8 Nov 2024 13:25:48 -0700
Message-Id: <20241108202548.140511-2-xandfury@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241108202548.140511-1-xandfury@gmail.com>
References: <20241108202548.140511-1-xandfury@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove trailing whitespace from sfp-phylink.rst documentation. Trailing
whitespace can cause diff formatting issues and violate kernel coding style
guidelines. This is a trivial cleanup with no content changes.

Signed-off-by: Abhinav Saxena <xandfury@gmail.com>
---
 Documentation/networking/sfp-phylink.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/networking/sfp-phylink.rst b/Documentation/networking/sfp-phylink.rst
index 5bf285d73e8a..4ce46aef6568 100644
--- a/Documentation/networking/sfp-phylink.rst
+++ b/Documentation/networking/sfp-phylink.rst
@@ -142,7 +142,7 @@ this documentation.
 						  const struct ethtool_link_ksettings *cmd)
 	{
 		struct foo_priv *priv = netdev_priv(dev);
-	
+
 		return phylink_ethtool_ksettings_set(priv->phylink, cmd);
 	}
 
@@ -150,7 +150,7 @@ this documentation.
 						  struct ethtool_link_ksettings *cmd)
 	{
 		struct foo_priv *priv = netdev_priv(dev);
-	
+
 		return phylink_ethtool_ksettings_get(priv->phylink, cmd);
 	}
 
-- 
2.34.1



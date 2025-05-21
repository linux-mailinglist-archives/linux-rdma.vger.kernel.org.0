Return-Path: <linux-rdma+bounces-10497-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13323ABFBE5
	for <lists+linux-rdma@lfdr.de>; Wed, 21 May 2025 19:02:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F07121BC7631
	for <lists+linux-rdma@lfdr.de>; Wed, 21 May 2025 17:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7D49261588;
	Wed, 21 May 2025 17:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YEUWSBcZ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E0A22F15E;
	Wed, 21 May 2025 17:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747846912; cv=none; b=WltghUFFMw1f4J5mJKck/N9hFHQi87Ddhz2r9Gud2XAuVNLvxUry/dA1Ige5DxVZbGAwpHUmUUPi+rZM5LpEASXuRh+wW8u8xCM8u6eSULj7Ozrbz25AkQZGJ6MjO18kjegI4PbhRmIZlgcJZZ2rhtpBWSSe7mFFyqjql3IWr4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747846912; c=relaxed/simple;
	bh=1VT/9jZFLOXENQjEMSO3cV9vUhB4/4XxiCpXx9AgHhc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O71NGXj7tt9OJ/5XOIyOrUAlDxeJfQw6r6OOr+p5qUz+VSZXJl3WTcNo07PMjbVoclXkXrqDM+IC4tMvu6mZzpfP2RK32Zmzlg/K9oI770gDFDKIDfC/dfRUC4p0fZzv1FaBNY5xiD+gi4NoMH0pWjC5XoqQIAbmXZXmFE3jivQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YEUWSBcZ; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-231ecd4f2a5so45245385ad.0;
        Wed, 21 May 2025 10:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747846910; x=1748451710; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PWmX5o1KZHES75Hln8YX3lrBwYIMaAXXEFNBxe0jHFM=;
        b=YEUWSBcZPXVjokfotdKKg/zka6gnfrsrHcdWXBsXOJ09PcndbTJqxv/r7aLFGtMlMk
         5HnMYpOHhZv6o2CoE1yDeLhW+p+HN2/QU15/Seoi67hdsJqlisZAPA3IiUCduEUvwmhG
         2bMU1q/B+ErhH8i8B6+V/eMLB23YdVwGeNIKslPWSINHY7CjLUl6muwcZ6zeMufXzSYK
         QkPfYjS9cEUEuVg8aBGO9IQST/XAmh4Bp3Gpa2F4SRgYmRRTWuyKG8kGANFgfEpkamme
         aCVPdM/FUyi3bj/kqRe4+agre36U4FIKEJ4ioyzrhLuLlmh4R4+ypAAHDXm2YTujpePr
         IvDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747846910; x=1748451710;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PWmX5o1KZHES75Hln8YX3lrBwYIMaAXXEFNBxe0jHFM=;
        b=qtNRERutm497IIbxW/zFKKbwVuGO0Hoh6a0o5oTx/kdVe+R9yPbf57pDS4fzEbreNj
         vciF7vV4n5ZcX6vnpiohgYDdU5ibpmdfbGhecUh8iY4QZKnhmI5rQV9e34ZNex8npuV+
         ZSo9ZgwPCSnJn7gWe5zDnBCkxP+97boMr5ZbYVYjBHu8qg2ynWt/kIAsSOPdy1yXe+be
         E2ECvVh4cISl4wb75dqLlOcSgoanADXV6lfEWK/wJcpPdPuouLAL7gugLX5qNMO9PdjQ
         supZ01BCl0H3dNEvybP5RKWUKchKwbZbOT38nntJZ3g9t8X5ignZ0IKdbpXgeYKPvY4+
         yWgg==
X-Forwarded-Encrypted: i=1; AJvYcCVFcnuMdkyDe29QHkYdvglpkWwgmME2mWykdBP1rlpHCJCC/f1zry9YZYhL4yNFQwsLed/AxIW9m+WyPA==@vger.kernel.org, AJvYcCWHKlc8cRBbNXs+Nu0KqL0JExKUU+EuXklRqEmwyn/YApNvje9KtYtwqWtypQI72ckXoKFtyIEIOfPBxyQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzdrn6nA4mLOlOT02NhY9SUXEta5xol8bC/ZKKNItHMHnPtWsQy
	v/pxb13EruT0rtHgnMgIks2zc0d0SWD+JG1CtGKUGUX3Mc94GVttelw=
X-Gm-Gg: ASbGncsAlYet/0RJwPsDP2sHscNkAQR8fl+kzCosaNwbyyoBAP5rU3tLPBXfCDa7Hx4
	039ozl0OJMZImz7wEobAATL2lM7Fg0GTXRmePAeYKYn2rPYeP7hdLAvMIpIV+RafZO8ILXFOexW
	hTOGJLY3KxHPEBgnQC5VlMKBjy784gYcsK5y3oSsOwqOuzojcaS7/MKBGTysUt3Ge3kS1g8ZTX4
	rJcunb5ygw5d+L/0y2gegx7Zj8pORzK/Jk7Tc0zDrwuefBqU4HGrYwL5J50LuZYGpLIUR4ka3S7
	X4ndXebM6xR8HhO94ojM2/tR/axwQgkS39zixxtN+BdQSqH57Y2u20fOo+20H4+B6E3UDGhrb6x
	Oq/4CTDocsZpl3XPcGA48G1o=
X-Google-Smtp-Source: AGHT+IG0Sa3DbuCkqkmdcG/fc0MxWlV6cSP48i9+QjTx97ZOfBSkfimF0N4vSUQyUW8Hx/YktfqF6A==
X-Received: by 2002:a17:902:ea0c:b0:22e:61b2:5eb6 with SMTP id d9443c01a7336-231de3030bemr301106515ad.15.1747846910234;
        Wed, 21 May 2025 10:01:50 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-231d4e988c3sm95414665ad.120.2025.05.21.10.01.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 May 2025 10:01:49 -0700 (PDT)
Date: Wed, 21 May 2025 10:01:48 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"skalluru@marvell.com" <skalluru@marvell.com>,
	"manishc@marvell.com" <manishc@marvell.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"michael.chan@broadcom.com" <michael.chan@broadcom.com>,
	"pavan.chebbi@broadcom.com" <pavan.chebbi@broadcom.com>,
	"ajit.khaparde@broadcom.com" <ajit.khaparde@broadcom.com>,
	"sriharsha.basavapatna@broadcom.com" <sriharsha.basavapatna@broadcom.com>,
	"somnath.kotur@broadcom.com" <somnath.kotur@broadcom.com>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
	"Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
	"tariqt@nvidia.com" <tariqt@nvidia.com>,
	"saeedm@nvidia.com" <saeedm@nvidia.com>,
	"louis.peens@corigine.com" <louis.peens@corigine.com>,
	"shshaikh@marvell.com" <shshaikh@marvell.com>,
	"GR-Linux-NIC-Dev@marvell.com" <GR-Linux-NIC-Dev@marvell.com>,
	"ecree.xilinx@gmail.com" <ecree.xilinx@gmail.com>,
	"horms@kernel.org" <horms@kernel.org>,
	"dsahern@kernel.org" <dsahern@kernel.org>,
	"ruanjinjie@huawei.com" <ruanjinjie@huawei.com>,
	"mheib@redhat.com" <mheib@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"oss-drivers@corigine.com" <oss-drivers@corigine.com>,
	"linux-net-drivers@amd.com" <linux-net-drivers@amd.com>,
	"leon@kernel.org" <leon@kernel.org>
Subject: Re: [Intel-wired-lan] [PATCH net-next 1/3] net: ASSERT_RTNL remove
 netif_set_real_num_{rx, tx}_queues
Message-ID: <aC4G_Pj118yoW-35@mini-arch>
References: <20250520203614.2693870-1-stfomichev@gmail.com>
 <20250520203614.2693870-2-stfomichev@gmail.com>
 <SJ0PR11MB58660E85F76E4A347197C768E59EA@SJ0PR11MB5866.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <SJ0PR11MB58660E85F76E4A347197C768E59EA@SJ0PR11MB5866.namprd11.prod.outlook.com>

On 05/21, Loktionov, Aleksandr wrote:
> 
> 
> > -----Original Message-----
> > From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> > Of Stanislav Fomichev
> > Sent: Tuesday, May 20, 2025 10:36 PM
> > To: netdev@vger.kernel.org
> > Cc: davem@davemloft.net; edumazet@google.com; kuba@kernel.org;
> > pabeni@redhat.com; skalluru@marvell.com; manishc@marvell.com;
> > andrew+netdev@lunn.ch; michael.chan@broadcom.com;
> > pavan.chebbi@broadcom.com; ajit.khaparde@broadcom.com;
> > sriharsha.basavapatna@broadcom.com; somnath.kotur@broadcom.com;
> > Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw
> > <przemyslaw.kitszel@intel.com>; tariqt@nvidia.com; saeedm@nvidia.com;
> > louis.peens@corigine.com; shshaikh@marvell.com; GR-Linux-NIC-
> > Dev@marvell.com; ecree.xilinx@gmail.com; horms@kernel.org;
> > dsahern@kernel.org; ruanjinjie@huawei.com; mheib@redhat.com;
> > stfomichev@gmail.com; linux-kernel@vger.kernel.org; intel-wired-
> > lan@lists.osuosl.org; linux-rdma@vger.kernel.org; oss-
> > drivers@corigine.com; linux-net-drivers@amd.com; leon@kernel.org
> > Subject: [Intel-wired-lan] [PATCH net-next 1/3] net: ASSERT_RTNL
> > remove netif_set_real_num_{rx, tx}_queues
> > 
> Can you consider more explicit title like:
> net: remove redundant ASSERT_RTNL() in queue setup functions
> ?
> 
> > Existing netdev_ops_assert_locked takes care of asserting either
> > netdev lock or RTNL.
> > 
> I'd recommend rephrasing like:
> The existing netdev_ops_assert_locked() already asserts that either
> the RTNL lock or the per-device lock is held, making the explicit
> ASSERT_RTNL() redundant.

Sure, will do, thanks!


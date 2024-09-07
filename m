Return-Path: <linux-rdma+bounces-4809-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0D3F9702F3
	for <lists+linux-rdma@lfdr.de>; Sat,  7 Sep 2024 17:33:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84F3E282C68
	for <lists+linux-rdma@lfdr.de>; Sat,  7 Sep 2024 15:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36B4315F308;
	Sat,  7 Sep 2024 15:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="GGFUtIn/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D8741B85DC;
	Sat,  7 Sep 2024 15:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725723187; cv=none; b=uWTz9Ha1A+uePxD1S3i35O/SunBs5oMtjglaaaRnrevdKm+4p4o4nAXZmqgyl8nLLVRv1QC5u8Zm2o2AmS9BctlfFZTuTQeIb/pGHFJBoxdYfn+y7Qd5H68FX/zU9r6fgX8XSsQmFE7EIAf0XD1nic6ZJjMwYJE9Jk+9O9Q7T+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725723187; c=relaxed/simple;
	bh=oHjQ7HgK8Yd87EvRVT1orABFAc/Um0D/a3v5RRH/Ioc=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=CWQcxWqLtu3vHnQldC9a1DkB/e0kOFp1mdNXumrNPKzGc8Tftoa+tNw2ixWVxhp94frLhTith0YRdEKjARYESUrJmuUE0DK5j/0rIIEl+JoutnL9iB52VSUgf9BT18fRMn6fXflq2Z0qV17hg8CjqQO7/ChBSWcqFZidpArFmB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=GGFUtIn/; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1725723061; x=1726327861; i=markus.elfring@web.de;
	bh=wihuS6INkOIDRJLvPODF0HceZ7BB6DFVMS4BkKX4s0g=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=GGFUtIn/x0Yjib7Y4e1yOKaA3LawIgwXzX4+GKFSTGPYUjXGu1bEp5Pk15O2AS4D
	 hNSt0ZBKybXpdcw4wOc1oylU1eZEYWVRDBoAegl7RGmW3WZNvuAKsV1KB3RndXKlX
	 UiTOOINChJQsj7EvLQaMrUjc1Iyg44nOWH7anByQrt2UEKJhZPXTwaS5GOs9d81Ft
	 Ga9LCGrNGegL9Aow2/iieXG6w1UpTyiIMVC6vNMzt1kc4gupOROPPTggssKDBJnJz
	 FMTROAglkrijureZi1maPvQedQtpa/n++HccI1BChPGuoKZvHxfHG/fPUBpOS7Mu6
	 tmBfowHsaRnK4RshEQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.84.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mkmzl-1sKCU60TDL-00kWWt; Sat, 07
 Sep 2024 17:31:01 +0200
Message-ID: <f60b0884-a7fa-4260-b9bb-ae680ff21150@web.de>
Date: Sat, 7 Sep 2024 17:30:17 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: WangYuli <wangyuli@uniontech.com>, linux-input@vger.kernel.org,
 linux-omap@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mtd@lists.infradead.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 Aaro Koskinen <aaro.koskinen@iki.fi>, Abhinav Kumar
 <abhinavk@codeaurora.org>, Abhinav Kumar <quic_abhinavk@quicinc.com>,
 Andreas Kemnade <andreas@kemnade.info>,
 Andrew Morton <akpm@linux-foundation.org>,
 Anil Gurumurthy <anil.gurumurthy@qlogic.com>,
 Anil Ravindranath <anil_ravindranath@pmc-sierra.com>,
 Archit Taneja <architt@codeaurora.org>,
 Chandan Uddaraju <chandanu@codeaurora.org>, Daniel Vetter <daniel@ffwll.ch>,
 Dasaratharaman Chandramouli <dasaratharaman.chandramouli@intel.com>,
 David Airlie <airlied@gmail.com>, David Woodhouse <dwmw2@infradead.org>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Dmitry Torokhov <dtor@mail.ru>,
 Don Hiatt <don.hiatt@intel.com>, Doug Ledford <dledford@redhat.com>,
 Eric Piel <eric.piel@tremplin-utc.net>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Ira Weiny <ira.weiny@intel.com>, James Bottomley <James.Bottomley@suse.de>,
 James Bottomley <James.Bottomley@HansenPartnership.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Jiri Kosina <jkosina@suse.cz>,
 Jeykumar Sankaran <jsanka@codeaurora.org>,
 Jordan Crouse <jcrouse@codeaurora.org>, Kevin Hilman <khilman@baylibre.com>,
 Krishna Gudipati <kgudipat@brocade.com>, Leon Romanovsky <leon@kernel.org>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Masanari Iida <standby24x7@gmail.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, Miloslav Trmac <mitr@volny.cz>,
 Richard Weinberger <richard@nod.at>, Rob Clark <robdclark@gmail.com>,
 Roger Quadros <rogerq@kernel.org>, Russell King <linux@armlinux.org.uk>,
 Rajesh Yadav <ryadav@codeaurora.org>, Sean Paul <sean@poorly.run>,
 Sean Paul <seanpaul@chromium.org>,
 Sravanthi Kollukuduru <skolluku@codeaurora.org>,
 Sudarsana Kalluru <sudarsana.kalluru@qlogic.com>,
 Tony Lindgren <tony@atomide.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 "Vijay Kumar B." <vijaykumar@bravegnu.org>,
 Wentao Guan <guanwentao@uniontech.com>, zhanjun@uniontech.com
Cc: LKML <linux-kernel@vger.kernel.org>
References: <63D0F870EE8E87A0+20240906054008.390188-1-wangyuli@uniontech.com>
Subject: Re: [PATCH] treewide: Correct the typo 'retun'
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <63D0F870EE8E87A0+20240906054008.390188-1-wangyuli@uniontech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0V/kSbOfOSES5ZSUPdgCZTIcGmmRZMm0Domxm/Q8KX7EnOO1CAN
 00nVkeHP/BEhc1uiKtEI0+LLwINCEV1nSlgo1pINWJyZ22WHQIdvHMPhXX9Dibh9lp2E6i0
 v1vwafHYbTjBcj52zpJPNskLr5AxrCpCr2mgG1bc7EuYHcZ6DtYMYuIgT/B6+Q7EQLT5mR/
 k9m3SXUYG/qEkZWV6kXvg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:eJQeW9UGGk0=;BIskQXK25THsuKgfSEMHNrqzAWD
 Y//x4rspd7L6DZ58YgNNTXjYwoWbQTnTYp1kc1vMll0u7cPyuTLy3xEP/ReuRFGA77lqQAibK
 /6uOnBeNuRrYH6ZgTxfXm3636B2h8/1HnqFUp73R/R1+Ao69JPmTyHFLi2sr4ElRqoF2AjIKu
 a1GCqrIr85L4vXpL0fSmKckM347JgzuW4ti8xbzaxVA7BtM6zATY3AkH+V/K0cwEf4Iu6Nc7Z
 Z+/81Xl/ApcMmB3mtmIzo0h4W8KrDqvOpWvQ2Dkm+/35DGoZb/Gg7tTi2nNrUxnh7UWb44rIc
 dltxjmgSXtVPHyFjzB2A9I1ucJA5Ouly8qh9iPQKkax/VcYVN2IRH7UUfFfp9hR2V6oMsYlrF
 6UHnxTjH4RpjyLjc7g63Dvh423vvN5KPDOeQf/w8wE/v5jJVBkm64wwCUL01y86qFtZoC/70c
 k8AkUqYGI08xMCJPT5v/QG7r1nYmjvvDTuIOP6aGw/0/LCNwFw3pp8uJk8FHiSiISgyl1C05C
 IK48cI9L+YLFJurUPze13oKlNambZVI0leiIyEdP0IstQTq4bAZkQBXv+U+SOV/IjOYe4kw/D
 q3fprWkvsM+xfSlOdzc/9vwKNZwkRQuaapTrX+xDzD1iRouYTIq7CW37H8CmkPpbUXMLmtvlz
 lTi2cYFS9sXE4yvAPx4OEnqrFEZOCiuLHwEPYGUlooyixxKr7l5kNU3Fttn6NlWU9zNxVdZDJ
 CTYRNkCsFkoz33K1beAdoI45/v6GjCAD1+D1Ov+hll037p+F42neH8RIJPbxRlzudy6O6UO2z
 MGr//iuh+hhfAAdwERNY/svA==

=E2=80=A6
> should be instead of 'return'.

            =E2=80=9Creturn=E2=80=9D instead?


Can a corresponding imperative wording be preferred for a better change de=
scription?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.11-rc6#n94

Regards,
Markus


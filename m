Return-Path: <linux-rdma+bounces-9410-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D385A886F0
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Apr 2025 17:22:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16EA31902865
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Apr 2025 15:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B37A274FFB;
	Mon, 14 Apr 2025 15:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kFYSey27"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52826274FC8
	for <linux-rdma@vger.kernel.org>; Mon, 14 Apr 2025 15:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744642967; cv=none; b=Hf4kNWEA0b2nUxi4A9RaBkyVGmLoGX4Ae13NXnBBE8MOsxMhzvooa2/nfLjr7uTqfhnPiItpwDpY1/vDAV/84QyS0w/f+NTBfSxfafgyKHjjLfLMYgbhFtzodfVmGbrJY4daQ9AlSYsNbPw3ZnBAfKM0dn8QnsgfkPSQksWYlxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744642967; c=relaxed/simple;
	bh=RaBjxibi9OpSLsL0pgUQXBGLegZ2HPMaVA4aQ8D2I9Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n1UcRKo3vB2dKtegM+LtgVgzXW/TCR9NZcTMWIoYZPkNt1Ijtcro+6euz9s13NLonJOjils0V1knoXv4atPFsD41s4vmqlI2BkqTxhYFcD1uPuU6dOMfY+Wns92fQJIDKl6IZDCKWPGh+krZ6a9ckRbOWMG0krJG50+CAGywxiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kFYSey27; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53E99nkK017633
	for <linux-rdma@vger.kernel.org>; Mon, 14 Apr 2025 15:02:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Fx9CLNx6B9Vh7w2Q67gBVSliKW/Q6vuPCUUdblElgFI=; b=kFYSey27HL8ztTDg
	RdpAvxgZ9m4z4naV34qjlKe322EcwPVu0dTVnfPZZoyOdXUJ5E7wux2TeOqRJ4cg
	2I23PD7rdAlxiI0HYOEieepyI1mShxQcF8F6Y1o6s3QYkTAyNatHpR3StJnJHmOe
	n0lIZfIVSP02j0rp4r8uiD7Tk5zoWDd1em3eS3Q37qd5aF+3T6OY9AqQFyTVpJ4B
	TrXR/Rrm3wfGoSnWErszLRs4u1X6Tb16EmX8Q9/jInhOi4z5JarRPgcVFD6QRjsM
	cI/1f4oldAetzdjVh8rgjuL2xxugaN6sKplOEl3/wFEr8GZggBwlvk6fkfz+6Ou/
	0XmDpg==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45yf4vd13x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-rdma@vger.kernel.org>; Mon, 14 Apr 2025 15:02:44 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-af510d0916dso1492025a12.0
        for <linux-rdma@vger.kernel.org>; Mon, 14 Apr 2025 08:02:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744642963; x=1745247763;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fx9CLNx6B9Vh7w2Q67gBVSliKW/Q6vuPCUUdblElgFI=;
        b=ul5jKkiSd6pTJGoTSDiUQmYLmS+lS980Go8v+9/qA76GnjXmh5Y0E8K1MTfTGr6jVq
         NkCIik7Dsofrtwq51/ud7tyjgarFMUWMnxFfCbt8XlRWfuJ1iUkT5cwme/UV3mpiearZ
         EPehsRcqsxLGdRkPQmpR6YQOjTRg7pXyyoZDg6N/F19iH5l3/EVxqhVBz78c3Xo2IFG9
         eCjzHGwxm4XquzisDwwPUG8YabvhBcJkpX0f7SQmlKhQ5BPRHaB80VvNe1lcFRLWTh3C
         FT1vA+H11fxvoSD/tf7MLYer7dP6E3efj2VuG92Nae0yTOIZ13sPRQ4dZ/oVp10cWDzo
         IJGQ==
X-Forwarded-Encrypted: i=1; AJvYcCVHHlN5nKRGAtlhPu4uG1nTnW1HIt0DbrTu09oEG9pnZuDxUD0S9Byo6Lbl78GBrABLqTaVP4e5RAoC@vger.kernel.org
X-Gm-Message-State: AOJu0Yzno9cXnPOqfQA7N7wmRJd2WfxHko5bEl+AeeXeBmGaQu2nsut4
	j71GbaDGyvUVtvHbOAwgEZM3mRKc0BPM+DsOVjaoerT+mtby3Ayxc3hJ9UbTh6lVHVp0neJU9qX
	EG8LS/7ELbjhLWpF5pjKBvrs/lKbI55zA/9AwVO6mrON4FvmoRb5I44COBxO9
X-Gm-Gg: ASbGnctzJilFL9FCGxfl7BXsKoPBAhY2uR98MC20+DtWW4JEGsMxpjeS1cuTssk4K+E
	6+GfkwaZsUFc6T38kk+jOlXJSvn5ee3yBUmLUi5Bnk7pdCzLG3/4TNINWm4nhUaCygfEKasxiMo
	oyb2J8hYyanhhyXxo0hhuQ/c1IVmmK2AVoAbzsLcmPbdsRu5QWDvaqtz1jkuNvwdrl9wWDmiMJO
	bNPzdTJYid8xp8UFME6FmpQvR3IOnA/f7DDVGqBb63jTwXeE9LWCMHugIPF8a6cN2hfLcZeWynX
	T/39wz4mW03HRVvASwu+3z4zTUzbo6INRx6NO1zJrIM2TrZDs9K+Ol4AxmVR1wu46GPvn/IXNWo
	ejhzQ
X-Received: by 2002:a05:6a20:94c9:b0:1f5:9024:3246 with SMTP id adf61e73a8af0-201797a39c1mr17925550637.17.1744642963240;
        Mon, 14 Apr 2025 08:02:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF1bvcHXdGUC9wzx8xCOFjLvQn3x2hUBSOQvCCcOvrLi0D37ffqN0AxJ/2rFL/I3g9ErbikTQ==
X-Received: by 2002:a05:6a20:94c9:b0:1f5:9024:3246 with SMTP id adf61e73a8af0-201797a39c1mr17925443637.17.1744642962376;
        Mon, 14 Apr 2025 08:02:42 -0700 (PDT)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b02a0de8926sm7855972a12.30.2025.04.14.08.02.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Apr 2025 08:02:41 -0700 (PDT)
Message-ID: <9c53011a-0e00-49f8-bf7e-b04ddc8c575b@oss.qualcomm.com>
Date: Mon, 14 Apr 2025 08:02:39 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/7] net: Don't use %pK through printk
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
        Jeff Johnson <jjohnson@kernel.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        Brian Norris <briannorris@chromium.org>,
        Francesco Dolcini <francesco@dolcini.it>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        Przemek Kitszel <przemyslaw.kitszel@intel.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller"
 <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Saeed Mahameed <saeedm@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>
Cc: ath10k@lists.infradead.org, linux-kernel@vger.kernel.org,
        ath11k@lists.infradead.org, ath12k@lists.infradead.org,
        wcn36xx@lists.infradead.org, linux-wireless@vger.kernel.org,
        intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org
References: <20250414-restricted-pointers-net-v1-0-12af0ce46cdd@linutronix.de>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250414-restricted-pointers-net-v1-0-12af0ce46cdd@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: tCe0HseBdLfzmON7-hwJu6kMQdyax8CA
X-Authority-Analysis: v=2.4 cv=IZ6HWXqa c=1 sm=1 tr=0 ts=67fd2394 cx=c_pps a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=e70TP3dOR9hTogukJ0528Q==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=2xVh5uQ6XZRltrFgOl4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-GUID: tCe0HseBdLfzmON7-hwJu6kMQdyax8CA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-14_05,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 clxscore=1011 malwarescore=0 spamscore=0 adultscore=0
 mlxlogscore=582 mlxscore=0 bulkscore=0 impostorscore=0 suspectscore=0
 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504140109

On 4/14/2025 1:26 AM, Thomas Weißschuh wrote:
>       wifi: ath10k: Don't use %pK through printk
>       wifi: ath11k: Don't use %pK through printk
>       wifi: ath12k: Don't use %pK through printk
>       wifi: wcn36xx: Don't use %pK through printk

the first four should go through ath-next and not net-next

>       wifi: mwifiex: Don't use %pK through printk

this should go through wireless-next

/jeff


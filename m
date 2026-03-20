Return-Path: <linux-rdma+bounces-18469-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2AyvIJJ4vWmt9wIAu9opvQ
	(envelope-from <linux-rdma+bounces-18469-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Mar 2026 17:40:50 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 015552DD996
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Mar 2026 17:40:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2AAC8308DFE1
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Mar 2026 16:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DC513CD8BC;
	Fri, 20 Mar 2026 16:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eNx6nhY3";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="h0FLgdUk"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4D03B0ADF;
	Fri, 20 Mar 2026 16:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774024336; cv=fail; b=pe1MLaRfLwey3Y45grZ4rtZVanVgOOYF985UeVBJ3z0CqL3gI9LYAyVIZUyEnZGTgUQukMGiQLOQQzhzSxhnQdp8RB/IQn95LB1bnDep+zU8D+FXzmsZGpmYsbyURb3gHISXNEJMtc+fon1G44rlnRX90D02zdX0T5XrkFRVpDo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774024336; c=relaxed/simple;
	bh=wwsC4KoqkuHhWqWP664ZrOGy3GRSPzXY9qH1AmeJB0o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qvHkyGwaRZJaadyImgD9Kwub7ynWdKlESwQomv+3yf8414z6RxA8fWL/mlzfcGRYG2fsmzSknbyBdwwbEiq0DLJHmh6wIbXBGFg3TWPucmz8lk4g/kTdgpzFZ9pE1UF8iuE7Pl3PS2qEc+PRDC/4PpNcnmnLX9Dh4DBdCHYFDFc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=eNx6nhY3; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=h0FLgdUk; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62K8YB701270169;
	Fri, 20 Mar 2026 16:32:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=wwsC4KoqkuHhWqWP664ZrOGy3GRSPzXY9qH1AmeJB0o=; b=
	eNx6nhY3EVyo5KNfeaZAgHwRFqSuI2NP0Yf604YQcyDO5vcvZLqav1E9ILKgDktn
	UDITdfK+Tl2TnGMRNvIpH9QKSRVqyi5fCKNfLKRSKuUFeXjwZZbnbYaLAJFTrYeh
	IM7FKIdQrlXne/2hTnWt7N5cIDCZY3MujV/wXzANEBnmohr9XkOWZ8iPBeqKzj3e
	phJUwjLD7u20e5Nd9++SR72eP/ilkCp+ouv6CXAQJlH58ciy/I5YBVpvTUuW7kCP
	QkjALYB3S+aIsfwaw466MDp85gQ+DbKna2ovDi3DcPoaVzdGRSr3iqLvaqNMJQ+y
	EFiFJ9PqpDgFX39befbDdg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cvyqc1ws6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Mar 2026 16:32:02 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 62KFbSDW030461;
	Fri, 20 Mar 2026 16:32:01 GMT
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011049.outbound.protection.outlook.com [52.101.52.49])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4cvx4effgg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Mar 2026 16:32:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Unmaeijn66Dx7SMnCyb+EIAZBD2uLCHqK36v9yN4JDnts2UlTCY5yHRfjI8wAwNoPNaeBJrS8rJn6Fz9sw2mCavRWN2l2LGij3o/3UblZI8+eqJnrNaRD1X/fPCol/BQQPNc7nTYsgvLTLB2Efkr5E6Po9tD4zmoi/ZJ6hX28QTlGxldOz7GNGFAi857Gmat9Ij9tD1VH+w0PM9KG1IjxUH9R4vLPVK4QeFJJ2vhXQ5mMNEgbJ9Bjt/ZTkIqt9T1khYwyXsv9f598IL5E6re5outBIMeCcxZHs58KwAfZk5BYvSwUSj/Pqc7IJzy1tohHvKBS7V3lVOiTHISpXFCWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wwsC4KoqkuHhWqWP664ZrOGy3GRSPzXY9qH1AmeJB0o=;
 b=CJjPBHwDSZoBjHEfLrWhjKzO13sSyFf4WCl9dleO8gniNAojtZkQqWpoUkg7IWurbZqmiq+/DvVBNqjhkvoA0sRaAunlhcdBLKAAYy2Oz7Sc8ofS4DheYrAQ8in3CbjeDplKMYLU+ntnZs7xTxRLGwLybAcWt686ToMEeC2tNJx7XZgJt0d+v72kGE7bksWHJ70yxFDkn7NuTXZBVt/c+RaOdw706aMa+y3XQZXm5obDLOXoxxTZn5qC0EszzhuL8z02aOMJSFU2E/jyGaZP8UTzXq1SFbEMUP2CqnoOPhmksurwyWZxfr7fcD56kelmmLGMNTj0dA2NN/7tJD7F6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wwsC4KoqkuHhWqWP664ZrOGy3GRSPzXY9qH1AmeJB0o=;
 b=h0FLgdUksyFjg4va6G/zVJ5hFQU/m7EBWrqtr9wNIbMai7rvgKlojeeIBwxY7+/zCFX3wNuHjUV1591F6TQ8zV1ZRPlSkyIgCa/O4W3Nb0Ggcmg+yDMkXkaMrpWHxt5jn+xdfm+r+qSMY5fTTN+fwflhEuvmJJHrlagnyQveQjk=
Received: from CH3PR10MB7704.namprd10.prod.outlook.com (2603:10b6:610:1a9::8)
 by PH7PR10MB7849.namprd10.prod.outlook.com (2603:10b6:510:308::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.20; Fri, 20 Mar
 2026 16:31:55 +0000
Received: from CH3PR10MB7704.namprd10.prod.outlook.com
 ([fe80::2a5a:b9d9:26b5:25e2]) by CH3PR10MB7704.namprd10.prod.outlook.com
 ([fe80::2a5a:b9d9:26b5:25e2%6]) with mapi id 15.20.9723.022; Fri, 20 Mar 2026
 16:31:54 +0000
From: Praveen Kannoju <praveen.kannoju@oracle.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
CC: "saeedm@nvidia.com" <saeedm@nvidia.com>,
        "leon@kernel.org"
	<leon@kernel.org>,
        "tariqt@nvidia.com" <tariqt@nvidia.com>,
        "mbloch@nvidia.com" <mbloch@nvidia.com>,
        "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org"
	<kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rama
 Nichanamatlu <rama.nichanamatlu@oracle.com>,
        Manjunath Patil
	<manjunath.b.patil@oracle.com>,
        Anand Khoje <anand.a.khoje@oracle.com>
Subject: RE: [PATCH] net/mlx5: poll mlx5 eq during irq migration
Thread-Topic: [PATCH] net/mlx5: poll mlx5 eq during irq migration
Thread-Index:
 AQHcq/Jc3KuDnivfpU60Ol++d2Bny7WezmGAgAFbMpCAAH/ngIAA5tgwgACUnACAAG1AUIAHhj8AgA2dWJA=
Date: Fri, 20 Mar 2026 16:31:54 +0000
Message-ID:
 <CH3PR10MB7704F1C4DC73FDB1D8CCF8488C4CA@CH3PR10MB7704.namprd10.prod.outlook.com>
References: <20260304161704.910564-1-praveen.kannoju@oracle.com>
 <20260304201151.GI964116@ziepe.ca>
 <CH3PR10MB7704DD1E6B9A671796FC6B528C7DA@CH3PR10MB7704.namprd10.prod.outlook.com>
 <20260306003217.GB1687929@ziepe.ca>
 <CH3PR10MB7704ABC8F3909C60FFDFB1188C7AA@CH3PR10MB7704.namprd10.prod.outlook.com>
 <20260306231024.GF1687929@ziepe.ca>
 <CH3PR10MB7704D1DF6471E59D47ECEB098C7BA@CH3PR10MB7704.namprd10.prod.outlook.com>
 <20260312003544.GB1469476@ziepe.ca>
In-Reply-To: <20260312003544.GB1469476@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_94b7886c-3e74-443c-a58e-890de065ec46_Enabled=True;MSIP_Label_94b7886c-3e74-443c-a58e-890de065ec46_SiteId=4e2c6054-71cb-48f1-bd6c-3a9705aca71b;MSIP_Label_94b7886c-3e74-443c-a58e-890de065ec46_SetDate=2026-03-20T16:30:15.0000000Z;MSIP_Label_94b7886c-3e74-443c-a58e-890de065ec46_Name=Restricted-Including
 External
 Recipients;MSIP_Label_94b7886c-3e74-443c-a58e-890de065ec46_ContentBits=3;MSIP_Label_94b7886c-3e74-443c-a58e-890de065ec46_Method=Standard
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR10MB7704:EE_|PH7PR10MB7849:EE_
x-ms-office365-filtering-correlation-id: 02ee7b42-54e0-486d-6dc7-08de869e32cc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 JSXeH/XaBpnmmHM96gZwKyY5xpbWIjCRMu+AR1UhRKWPy5+/m0HhVI4KTrIFiXWkocewbXelGj9ntDolEq4fki06Phz2dkCVsaWB9/QhsmO2TPw1Tk1RzjtFzU4ZGH6KdQ57x6AsZPXFNLkQ472wPnWPj8xIwmj7JpK7qfqyORTJ5gmcUuWiQgyo1QhtfDFwhCOoxHtyzRMTLOaV1dujcqvjamqZdAcZ+ywi470l07uva//VcSH7gqwZHMKjrfu/1FgH7BV8oaoxXby1OPwk/nzS+ENNkT0D0eOdMIl0EEKlqQxzaBB1dYmzf7c//uUiZNUzHJKLlg56kSWl5kglJtbuGqdSelumrvF2TAD9B2p9FfZCaCxWcikz4EYbQecRegG9nmqF2uPt7/0nAWFgC8+7OR7wOt464epe6/DqQlD9J8Liw+s0w13RuMea5yi7sf5eiryTQEyHxZp+3+gSM0fzs/0n5/ia0iycMg+xaFJBRm3/6+TAG2ttnv/I6LMuB4bzX77GIQbIlILUjTIFL/aK4IUs5oeIWSbuhuuPDoFpJJhwYYrL9eU4HQYpfIvY440RXxPtOAXxqHVEILnwSP7bPrwT6sYxCyMxrYQA4e+SqO/MEUfrWfqRt83sPFq3pXsIy210GD2S2Vl7kTrc5MMEM9leRtWZOfSOyYRKzyK3DAhrFut8ckk8q71dNhwdR9JWSuZOUblIS/pRh7WSea/4vF8nyOMlFPjx4ZA3SWnv31NjnwYh8nseStCol2edpzh3lT9heph4Dh2dGIlRc9n5/EPOd98aoOgJB299jXw=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7704.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700021)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?POC8w9W2LK+VOGr2nxZIZNldD3QEEKaD/1ZdnSdptpr7h28W27s1IcbL9zyT?=
 =?us-ascii?Q?ush1GXfAKijze+3pn3OPXS3DOl6H1Y+b2hi8I6NvcSVa0lSDchMhR+IQreS7?=
 =?us-ascii?Q?YHZ+Iv9p6HDM0duIBH07ySPliSXJZOEBqoj4kfs0mv8xWZlNB+wgXLm2Jfm9?=
 =?us-ascii?Q?Fd3BsfFiN1fh5+Mm8rx3cMqDGIK0T5NB795b5Ip2mU1ZhuE6OsOZQmcW6i9w?=
 =?us-ascii?Q?EFfQw3Lxb/RbXVbHEJf9CnfRJZeMlu9dfxd22tYzsa1V4t8nq5FXyj0BnbUx?=
 =?us-ascii?Q?/0r7+8F00n9SAtskTJWE8idVpeVMGbAnzhcVUzwTKTqFN+tnW7WI+DUGTNBr?=
 =?us-ascii?Q?Lr8KDq/lf5hdjj/BR3mkYagBb+nu+orqih9HuCRHzdUpVapnB67OgH80cmaa?=
 =?us-ascii?Q?57P4yo9mXsGVvvJ1DSs4u6242j5g+N8Sr8EXxVZzbGNwh0Knmj1p9dlq5MpJ?=
 =?us-ascii?Q?BIVL6kVz7EfAV1ovDLrtUNHwt7Lp03RtfoIShjRQmi63FnD2JUIyTSroY62H?=
 =?us-ascii?Q?8MN1ep2ZnGA1SCUaPIvdIcZpWDW8LvO8ynpq2EC0GXOZeknCjKNEal2FH89b?=
 =?us-ascii?Q?oTa4Ut+g1CJAw4tFDmUW68CK+9k7cB5xBcUJlF4Rp/yjdi7BkvFa0qrn8PQD?=
 =?us-ascii?Q?YpGbzlCunQtpSm5r5ccZ6PIm0MeMo3ossoq2XUU4WZPaLI6saJdsSfwm9FJE?=
 =?us-ascii?Q?Z7AsqZrnsB8kmaxj4ik9p4+MX+BtWs3GgXO1MPBHNs53SCzoVsl4BWaHzc45?=
 =?us-ascii?Q?fwqehqU+fMqapiBLVXjGyUCkAEHf8pLwayEdCvHTE8Z2fFnzGeIL9JOCE5cf?=
 =?us-ascii?Q?Hz0DZsus2l79YDK706FGVKncfTpwqQ6ci1UjlCBcw0xrLdtuGhqxV84ENPJc?=
 =?us-ascii?Q?+EiHG7c5QIMh3ke50I1rSKJiKdenIhLTDdy4RLT5dQm6+qYci9UTpGp3It2u?=
 =?us-ascii?Q?SLy43B3BazXyO/KH00Y0ssedXU2SFHNFRcdlk+Y0s37febZWRtVIhc9uEFYu?=
 =?us-ascii?Q?/DT3HeHCAIWLEPGrz9tqjCgg1wzuJunnEPU68jYEnvN+yERQvVcz4Y6EDlf1?=
 =?us-ascii?Q?x/0RFw3epWu0GienVjNTe7xvqu5C3RkKSEjn8jYkMM43EJGBpXUuC746gDG5?=
 =?us-ascii?Q?aCBeXacuK9STTTjgv3f4khH/UT+S4Kheff+QmTEeKXF727iK54iZhZIGX4l9?=
 =?us-ascii?Q?lhyJsBjAzqcahRGpiUkd38LPeXIDR8/MQyQGPypdKbBoI3hhqxYCL+IitC0H?=
 =?us-ascii?Q?om29vXJ9gjcclqvNIE7wufmOaYKsVYIcEuRbs3VA3zvZ9YSWol9QKt20hwAi?=
 =?us-ascii?Q?c5u5FNa2Yrlp9YhbfmIbrtwpVhsp4JuzQl9cXrTEKHQX6NWmvGs31L8ICg6h?=
 =?us-ascii?Q?2DtzmXCCl9yBIXbdAoeDhrFuJXX3CgNbolrYCoo9/zOiahfEzFHt1gHQBMg+?=
 =?us-ascii?Q?/NRp1mQf9Cj0B9C8SovZXILdxWjj5sxISDbzHn90K9mLUt31iwv0RWQ0OUFK?=
 =?us-ascii?Q?uHNrZAvhbFwhVpNPzm+uenCrUSZTDm2rDC25AUWamVq0G0WHDuBSzJM72SRa?=
 =?us-ascii?Q?W4lkb7JLqP2mm+lax/4+gcfpIUVm2VCXtyWTALm7GwYd9AlhLc1TKUadoWKB?=
 =?us-ascii?Q?6XID9P5L7f322yA6pQKS9eTczF7TPq1iFygvTZlk4nGPjHPKYkmuo03/iqSN?=
 =?us-ascii?Q?166jL5MZcaGTfpnlnqQbb1Y5IYV142lGN2wlg2BUFtzcQ1F7m7/f+ufDHB/g?=
 =?us-ascii?Q?ViNjKHRiYg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	as+60ASOt1YB51m1HAkLA5y6bnva3uOemgoF7+Z3KmCw6pSt7b4rW9ZcZQs27SAfSHfIRAnfTh+7Ws3Zwvx8xMmGdYd/K6kl67MwEySj60YtqF78B0GD8EhNoCPrvZRXopuGDcW2xXEF7tkM/PuLq/s1TOf//hKf6UJZc2vJR9Cl0ZWU1kwBGQ72GyINorPtgNyncPU9UDdnz+AvY4s6fFKfQHuQf9yXJYRsJhuvQOotOIq2fWgkPmAUB6kJEAZCvKFWgh1yNBeK+Lek9rYSNzIU8Dd6I2tG9RDhQEXpD9V0zB4G3xy0LOzqX8WM1PK8Uyjwh6IhxyH+za5DC5xhIw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	zodeqMmMeNEYWr7VLSRFxDV9O7KB/7alFil6/JOaz1NYzLhJ+VBrsPuna9AyJosIfup3m2Grl6zh1Hxktbh5AEc05QlxN2Iv/M5WAiEPWbNqoIg+1rGAyBtwIdyqqn4GMxrXvlViQzie+78+wXOnoRwu/2vHNuKfifXJ/vNjmE5C/8I7yzhs9ZwHD4SfMoTWb9nZQZbggQuMMYPA68Ytj6C/dqD3zjcCFWOIMQEa4lXrGD/jDz7q+0nCFNMM/j67JJXdR6ytQxKLt3rM0n6d5ZLrVFpXct71cDjlpxCbs+mDZM9kzP52rmrK0lA9TrBAg7rLE1mcSsd8NKAtdqNAAMP9MI2QpdMnMWmCBW4L04RYBd1Wi1Xx3Qv7H/nQL0jXFrWUoOS78z2cp6wczB8N3MGWuGVEnF2PDNmloWQ9uqeSHwc9D0pNfamCKjdD5621JH+FluynWmDlv6D0RW5yaQfEjocf7EvXAS+x8kdE63WswZoAx0uIl0cX5E2UmT3/TFcP3vFsxuz354uWKZcSKq8bdH4lxJWqI+wT6mzLyo1SdCsJ2OFiaOdgny1KJAq/4i/XCaQkLL70F27LHov+yeugc6p7KMdhnfg5QA/VLkc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7704.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02ee7b42-54e0-486d-6dc7-08de869e32cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2026 16:31:54.7986
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rxB2H3B7UcykVs3D8o/mmiLsVlH0wIoKLbxoTRYLx1UnoOzfMCbh3EAqf0zixClW00Yy1o+huVpv/FSt9lekwK0vRLRghywR9C47zYfhWlY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7849
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-20_02,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=734 phishscore=0
 suspectscore=0 spamscore=0 adultscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2603050001
 definitions=main-2603200133
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIwMDEzMyBTYWx0ZWRfX748FAwMkJFPL
 exsCGT4RJ3Wm2JQfiSeDc74uKGhpJBjwHvG4n1QxgTbvHtK8mCeVY9ULHfPvbV/d2G1Gfm1luGi
 aU36aGM44ARWh759DgafxXjF76jCFAqmB85TLa8eli0OEuDR9YNhUH6n+YHPuokHO01acLPk1sF
 ytyicMTEuT2JcM5QUQYySSE2Kpt3INGhlwQuFYAZpohVL0bDLJA8TeBBfePeHHPES2vpekEoXFs
 mOU9RulA9/j3auzQVO/YvYDylCYeEaT/R6QiHDndbQ/qexocUp9s//waKO594Se5jQw8rXzP1C5
 s+Hu4cQfbyR9nAr4e2TeL6Fy8xo3fnttzBTOP67oiQfwPzepQ+s2f0DpZjyOf7dDBHwr9IXSiK2
 BpR/R6gZjD8aTr+InPMEOQKSccQBFPOSr1rVxve7DUCDb/CGwKwwza26hxFLg1gihrUeVb03lEU
 ToQvKLntMv2nzRg1rRg==
X-Authority-Analysis: v=2.4 cv=J8WnLQnS c=1 sm=1 tr=0 ts=69bd7682 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Yq5XynenixoA:10 a=GoEa3M9JfhUA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22 a=BqU2WV_vvsyTyxaotp0D:22
 a=MqY7D_EDWX6Ensqp0jEA:9 a=CjuIK1q_8ugA:10 a=ZXulRonScM0A:10
X-Proofpoint-GUID: 7GaiLg7uGOw72m3SFCkBk8x6UD8OaMeD
X-Proofpoint-ORIG-GUID: 7GaiLg7uGOw72m3SFCkBk8x6UD8OaMeD
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18469-lists,linux-rdma=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oracle.com:dkim];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[praveen.kannoju@oracle.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.987];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 015552DD996
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Confidential - Oracle Restricted \Including External Recipients

> It is almost certainly a qemu bug. If you cannot find it, then I suggest =
you work
> around it by having qemu inject a spurious interrupt around the migration
> situations.
>
> But make sure you have the already known qemu and kernel bug fixes for lo=
st
> interrupts on MSI-X writes...

Thank you, Jason.
We're working on it.

-
Praveen.

Confidential - Oracle Restricted \Including External Recipients


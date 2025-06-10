Return-Path: <linux-rdma+bounces-11175-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F418AD442C
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Jun 2025 22:54:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01BF51888DBE
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Jun 2025 20:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57A5D266565;
	Tue, 10 Jun 2025 20:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="sDGnW/6Q";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="IODJXMmh"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0B2228CBE;
	Tue, 10 Jun 2025 20:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749588878; cv=fail; b=RjRETaJGkUyXHYGCDlMslAF1Dqn5sHy9fYv0JrHBhYn3Zc/xtTmpWHCK6j5/KGteow7FML/aJL5TCyMro5zwQg4w1n7bQcFUv0dhFopnE4IbtoNgvfJQPv+Td+oifpJt3MQ8c2zHi3irzSHClVdQtSFm3Kn+eVs1yPraCHI126M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749588878; c=relaxed/simple;
	bh=d9Sa2XgB/7fvYxc6ffoyeFEFf6RsQgThXTysknp9DS0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ghA3af8mBXnI5oiMLwvGE21hupsUBEjK78msYTpNIkShJX5N+N4PUpRFI6byl/pyJyC/cgOAV5Tbh4niyflvE3ob6l6FPgMSwNe91u+FHPPkkFDHKlkgyRxYgTWYd1zzJNPnXCv9w4H9Q68vLPoN6I3wTRhxch2MTK5EKuWIrIY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=sDGnW/6Q; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=IODJXMmh; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55AK6hF1015756;
	Tue, 10 Jun 2025 20:54:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=9eaudGbr8aD//gQx+Y
	wqUWS+EOYVvMpv0mlMEvdiJQw=; b=sDGnW/6QZJg7alIFnMzM93oX6+GkbJETIW
	nmsNOisaoHIw3xaMgQ8SxmtfjSs5TmIPNT2z+oZ+JIjsXr9JYVz007NsCBDOXNK/
	bkEEvpUm2PvEvQYCalZijLOzJNtI3JlffLL7oUa+w4T+Y/71PbLHb8IXJ0eZ5f4n
	AgAvR5zf3PZVUGgm8LPRGUzretH6bDK2bPGWvIRcjvA2+iR+ux9iLY0ERaDKmt4Y
	1UCmn+XegOyhMh49riJ5cSTi8y3YfKcvvypMr3E2bkMI7B9tJElloBpqyKdhtbQo
	NayimtzWQwvL/6w6zqVYI6StzT4q3qHLjON2ysdx3xTDpZf8yeLA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 474d1v53xw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Jun 2025 20:54:33 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55AJ1Ktn012013;
	Tue, 10 Jun 2025 20:54:32 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10on2041.outbound.protection.outlook.com [40.107.94.41])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 474bva8stq-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Jun 2025 20:54:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZIcOSeVy/VdsAjAj6HFir5pi/2qieJRaoPQTgZUfvCvdpQR0VmdFQXe+1UEvSMP1iEu4Qa18ODezKhBJ6WI+NJ+ILSAxtOZldoYjsZxZjuuGs31Ms6bJGK/A9JuBy9czpQL7dhyWoBRdrHUtthjVG5eLibO5OsVLB1R168nX9ERHoej4BpoiWR9fIveajhHtkcsrdhHNlLrbqeOondz5XWhoQJRO8p3+zpH14kQnpGNH2B3TOaNCpwC0r/Ycne/PbKVPDOjGElBtbiBTnRy5A2D7I5Glk2k7XlI8e8PGs2WJng9Q1GTMtjSrxq94B1Sqa6/QF/+Erof/orPPzybEsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9eaudGbr8aD//gQx+YwqUWS+EOYVvMpv0mlMEvdiJQw=;
 b=AknwswE6Z32OCCi6V6jNMVR/4h/DjffKkglsv9qam/NqdGI+NC+Bg0BLxTuhwbDfeuYbnehZQHiUmT6fgEMx+y/KsijW7JmBhb+pLoccjI/F3wEmd4/auOYay2cfqIPr0HVGUMeX049gZHbuu+kyag9K+cQFlDNSzkvRF5t2dEGGRuG6OH+DOEuqq3vwGpjoDNOAzzkg31NsnJsBI3ePyz/3cABAAUQMra9Foxu+N6p+Zvg20a2iOqSMtDxLLu/l6kC+YiV3Ng6mu/Opq/HYzwcAeZ2UaOYcxPCEX05QBCWEfiGbITibK76SvvpJ/M3HJJhPPK9tDR9qsI5VXBBWXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9eaudGbr8aD//gQx+YwqUWS+EOYVvMpv0mlMEvdiJQw=;
 b=IODJXMmhcTdMgt9Xe8M7dQdEAlmVL0NBaw7HWsBIYpLjbeefBikHth+PZ+2Hu32wJJNwAFO6ZsA5VSZS+9bv+dR4Qrm2WldanJatOCM1+4nkke4BJOi91O4gNjH6gE9n3IGvmF8hXXxqwCzm3IaTMMTiBkgFjLCLVpIXXaj/7pU=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SN7PR10MB7001.namprd10.prod.outlook.com (2603:10b6:806:345::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.18; Tue, 10 Jun
 2025 20:54:29 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8813.024; Tue, 10 Jun 2025
 20:54:29 +0000
Date: Tue, 10 Jun 2025 16:54:13 -0400
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: allison.henderson@oracle.com, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com
Subject: Re: [PATCH RFC v1] rds: Expose feature parameters via sysfs and ELF
 note
Message-ID: <aEibdVJDL7oolbc1@char.us.oracle.com>
References: <20250610191144.422161-1-konrad.wilk@oracle.com>
 <20250610191144.422161-2-konrad.wilk@oracle.com>
 <4531f0f8-db0e-4a94-82a3-f1f8fccea865@lunn.ch>
 <aEiYNk7JjdOnK-5M@char.us.oracle.com>
 <aaef74e8-5517-49ae-aaf5-2ca82ca4ee28@lunn.ch>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aaef74e8-5517-49ae-aaf5-2ca82ca4ee28@lunn.ch>
X-ClientProxiedBy: SJ0P220CA0006.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::29) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SN7PR10MB7001:EE_
X-MS-Office365-Filtering-Correlation-Id: 3453cb1f-ae0c-4137-5f15-08dda860fe84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?k+8OekJG/solX7ED976h5StOXUPs2rjdXLQeVjuV3t8chyIGGoePmHEBMviw?=
 =?us-ascii?Q?ILQkLoTX+dKREdH8PYkT5ax5X8GD6dxixhiuHs9W297mmsnVZpMfwabUUuD6?=
 =?us-ascii?Q?rBvgbZAB5eKruYReU9MQJge08rl7XQhc+v5VAUfOAbUgxrlIdVkiW3G81SOW?=
 =?us-ascii?Q?jgk1jd4Lxs/3N/FYxOgpHjEqDRCQ3As3qUVIRYz+0pPxc5cbV0YJhd1VkA6E?=
 =?us-ascii?Q?ZAnYYTVndPsd/IbZ/yDHFIszQNA2FLbqz4PW/UFKixbPHJDfmoNGU0QRY2yu?=
 =?us-ascii?Q?PuzVsHsWy0NqaQqbgNroj6ypELbxcoov07vzS49md4ztT2mSsedbsgI+6R7w?=
 =?us-ascii?Q?+ho884YDV03wfAoLfDk393GJGo237QA6w6Xl0RREKyUwVCh+5W0kEj9BuTnA?=
 =?us-ascii?Q?3zfqyfOph8oVsqz0UkNlg80d4E8uVgnSIdhScMufEnUMNLXwp8ORF/GawMgS?=
 =?us-ascii?Q?Aczqdro+ZhZnYfD1hLRFuhgTHFzM0gpIOoPbE+9Sult1Lz4o4bUkVDAdnDyC?=
 =?us-ascii?Q?6HBOn6A1orsSxDzu2uXITax1Q963rrkik0T8eCCMoHJ3kWQHifAID2/Pj7ES?=
 =?us-ascii?Q?rUdryMKMF37p6pPZ/qiALVzjkDwnnCZeIKu7/s6+OSU5PD1Ce8Amee03bK+U?=
 =?us-ascii?Q?FRf4XHs/KcW3jKipP2M0K/3863KXqTnTkkDE+9CzYIowx+lkSeR+uBXsC8Sc?=
 =?us-ascii?Q?4i0XZF9HItQ06xxa+qeY49a2Y7Fp8ccKugQMxv3ZCgzjKGRADuBEtWbeF+4q?=
 =?us-ascii?Q?fePLTll74OfimUkl49uFwH/7PR0azT7FM0VVMvD3pzfZ8FYAd0KOY5fF8Udx?=
 =?us-ascii?Q?OhB49RuIINNZcB54ja4K8OcxbFeDkZ9g5vAdCKkGWE90PkN9gOdq/SKWTWZS?=
 =?us-ascii?Q?Z14hnDithxBUC4oCIrNSamtkQbrEZPPZrZ7LR980SU8oj7tfv6KSCpg3P/Z7?=
 =?us-ascii?Q?s2oHf+5lu0EW8lmcsHkJv/w1OpBWwNrU9aa96ZnAIhKiu2wNDqIUBG7BBWOe?=
 =?us-ascii?Q?OMSBdWiROZDLA8B/YFpXIkW4sK6eF+xJ91YTXtm90pz47jMmiOMhjVmOcWui?=
 =?us-ascii?Q?jo/38TUU6HTwCfFUsf3WS5sRtpYIBD0/lr5lcDp5YSFwfT4ldCbaHPLF0rrF?=
 =?us-ascii?Q?wdxEt1vtArF4vFvZLhzU9jQimpDsz6/lhwHq1nj/ZKQnqpT0FCaGNgVqtyvP?=
 =?us-ascii?Q?w63U1r6Assq74+8vwjYpecEF173aur51v/T5424gYP312HQR5h5OFbFu8UqF?=
 =?us-ascii?Q?tmnvwVMYol6aOH3w68Zg+aTUQjJZGW96wtzBveybxUE9QiGFue7eKYZhCpBs?=
 =?us-ascii?Q?FXryjYte6AiwbMX1ujvSx4iX4EQCOdgC5RerEbaM9PPRFwijg/Rcf51EbeQw?=
 =?us-ascii?Q?DQ7MljPv9yc8mXgEmzLFYIKY4dUkraA/SKJDXAxB5Mya9+MeyXJ5qLW2TmQB?=
 =?us-ascii?Q?ygAbWct16jU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mXyef5vjMTd/x02vV8//A9IiXZ/CbvXdHoK1/agqScQcJQM59OjKjx4pRAs2?=
 =?us-ascii?Q?SfXPOSkPa9ZVuk3R91ohgtPyux4M+SkYeCyQDutcwqUFabADe+pW6td7aJIm?=
 =?us-ascii?Q?r4dl5nYDOY62lEMUWKfTvRc3TQP6Q1J6lWKOl6/h51WpuH/PsPj+xshKuQWa?=
 =?us-ascii?Q?vdifOO9ZYzrEF/CBgndm8070Bkdb80zTeb97OILCtWjkasRWD0pQ5Q1paOZD?=
 =?us-ascii?Q?ZPbqbgwKpm5fXaBhjK7OWRbXqekzj06rKQIRT8thmIh/6dkiACetg5Mli1j9?=
 =?us-ascii?Q?jba3O9xKdJmiQawdkI1U2LfmhtRHbTsbaBZOvswCU2gOV9ey6sfr/uhPXX7r?=
 =?us-ascii?Q?3IelG5kavHFMXaPnF5jLG/0BcUqKj8lJmpFHLmNDr9RTt/O9C7z5zGGcWwYR?=
 =?us-ascii?Q?/9TgGy+zQ41e0SBhQtAg2Vu18bJe+HblM5HvYorVnVBBg18429oJMtLvjWPd?=
 =?us-ascii?Q?wPfyXPy7vGWqW2VopSwHha3cXh1CNRujsi79OlWIBgs9h2kBpcpiOHGAj8sE?=
 =?us-ascii?Q?2gaKwavr63lw89SHpG83LAXeB8YDNZh0J5MgWGlhdQM+mw9IImpf4yiT23m/?=
 =?us-ascii?Q?65gQ3c+8rfMtVd82AN7sgEiq/WF+qRAH5ipkiaThM7Zmd0Am/JleiIkw1P05?=
 =?us-ascii?Q?6IbwLK4fWgDPWw6QCYlap09R79B4dsCqFyzCAURPlZSm4rS/AHzbZVl6Fqxv?=
 =?us-ascii?Q?d6Oke+Ngi0qmlXsIW638BDf/kjOePgfsRX7pB5utNVNVfgkbDtuqfc2fucwD?=
 =?us-ascii?Q?zYF1cmbzfzeAD7+O89yeloKw5g+oWuN+AWbnCXYRxRnJIc/4N1bz260eXUQj?=
 =?us-ascii?Q?HK1ai1BOZEcSRE0d9o5C3dUrgVhJ9ltEEQmAq7Niy+V52F1qm6slES9Sy7bW?=
 =?us-ascii?Q?IxS22VVcfmvxKELpJVPdkk07SQwalUBt96wmI+TgbTAuAC0NU+FQI/1Yvq0Y?=
 =?us-ascii?Q?4LtUheaFRoUcgBi29MyFKt4SOpTDPHDfTN501sCoe8YN8kbGsMtNGBqRM4l+?=
 =?us-ascii?Q?R5X/kJnijl1UbSDRZBb+5IO/Lfv/gDK3VW5ajz8vJGwJNO6NhVISt0E+23KU?=
 =?us-ascii?Q?F7bUebmqQiUKiNmLDvBiGOQzHXASfEvOoyvyVFYbrl1BEL39BmUgg3+0MqIP?=
 =?us-ascii?Q?IrqhK+ZkC+c9aymrTOxJqYby++JfaswohnBbhF9TStob+eqNHJxfxFbVuVhz?=
 =?us-ascii?Q?g1+jsabQPZU4s8RViBkvfAA/NM656AhC3GxZ90Sh9A/kiqruzz1e7Vtpx7EN?=
 =?us-ascii?Q?vvfRmdjNksPvdBak35pW20cX09ItmNUOKLcUmNnj30ZhQXd+MdirEgrfZ9D9?=
 =?us-ascii?Q?MG2ewpexkNGB8KxpoZllC72TUWKONXTDv309H71ycIVGK1YQ+uVNZ05USAVg?=
 =?us-ascii?Q?++i99G/zrc5uLINTycgk/Xso0DqJZQ7rczAxL1OV5Wa7W/dqa5EGiuyv5k21?=
 =?us-ascii?Q?jt875ebFdeYIooP9dsGSAn1Rk/bxI0odojIKA8dKIqRi+vLrzbPm43rSw8+J?=
 =?us-ascii?Q?BOSvbkiSjO1k4XFFUCGolek4lYZDFTkLYBJnI2UFetRpy/vu2QbXKwxZZiMc?=
 =?us-ascii?Q?sQb5I8bpX4WXPzgW4n1Xl0ny0iap7dBeHZRErpBMN/R1lh2tHK8AP78P/sny?=
 =?us-ascii?Q?AQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	HelSMFKAaCyR6+6XC9A5CkKlsSpyqDTRf0nXnVo67UKJ03dIcw373yVeg6YTdpQfR/RgI+oZ93XJR5NcNdR4Au1PgwrpykYJcfn0i5XSl/FgjoWzJ8VSJMMyqHyiOoR43f2gdH+K9lnNl9JMuYW9VQCZNBHHUIiRdcnfp1QwP8RItLlcOEBmbX/7zPXrG00x52X2yNWlsNfednlj5Wn9Uv4Bw//zqxin5w3yJRVt3zAHMyk7qFgAGt5KGco8ps8IviHZNm9lnNCfCyNw4oAgpACQzspxFaRuRLZJyplM5jiahrT2cMlaN1G70YXJvb9QRysYjPNn9CBnQ+FiRNeRCYCvh66DZtpbKz1a/3tun05AM40hpiW0LxjQfPgIbLEVIRwZIL7PRarucPFbaiwrRtr8HtbnvFtviLTdENM8Y+AqfYxV5f38kQff8nRPhEdIWLIaBGPiuFzYEwXZTMEWjvASyNmFsd+na1OXWe/TFw04jxVF4tYPm2woZZ1dqIUykS+d4KOPYfjHei1bY6Ly8vlRUW10yvGswKXEAALFNwUxK5IIVbO/5rAPO3nRUoL9XZSEuIfOl8VJWepAylO28VIOesVLVOXAQS56y/okqkk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3453cb1f-ae0c-4137-5f15-08dda860fe84
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 20:54:29.8496
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WHQVnkgUpy9JWfQYDfPuqHaq3VMeCODaz+iDy7Dog2hZJ2EkwDCg5eGjESmibYZw3K1cJWHOMGfFG6MCTURMBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB7001
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-10_10,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 malwarescore=0
 mlxlogscore=921 bulkscore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506100170
X-Proofpoint-GUID: SzIjLuv6XY9MnwOLPDcVEEOIsvelX26i
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEwMDE3MSBTYWx0ZWRfX34CXVuQq25fI pqHY+i/xmXEXTzBRq8qHASLFX4LL4ukKtWgfoDOEUOJt52Lz6kOpZzdEJTw7LeqOyVbs4YPtuMh kLY2khRz1kfx5QfioWL+9/JU8zwIYQxiENuf0BqbQfjLREsxGMg6Hhu52SKJufBkcj5cLvutPSC
 XxGtdPmAlCqfj74dZsDHTrFHfKEkiL2x6TiLChkp+NtPycU0+B0DZDo1HWs/GWJPtd2FpCpSdOd fFa6v5oQ2ZvhnVPhDAmdlsxctJMpEnzasmGPPymM0vBug2a/q1q5fNMQN4xAcZouk8hE0C9nxCS ZBA+qSKQsgWYWkVraSF3L1YtMhwFKTdkIR5aj4Jz72ndJbkYdph4um/0vdU7POVILcap26wEewk
 vDDu48K+MSANzZlcr1YfMzN4JLPW8GZGekecePVzDvFDZyUCphX0h0VaGIrXYQwJjwAmSUPO
X-Proofpoint-ORIG-GUID: SzIjLuv6XY9MnwOLPDcVEEOIsvelX26i
X-Authority-Analysis: v=2.4 cv=d731yQjE c=1 sm=1 tr=0 ts=68489b89 b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=DbPS21kOr90SodMOmEMA:9 a=CjuIK1q_8ugA:10

On Tue, Jun 10, 2025 at 10:50:06PM +0200, Andrew Lunn wrote:
> > Right..
> > > as /dev/null.
> > 
> > Not sure I follow. Make them the same a /dev/null? Meaning link them to
> > /dev/null when the module is loaded?
> 
> I mean the contents of the file does not matter. All that matters is
> if the file exists or not. The IOCTL etc should never change, and if
> they do, the patch which changes them will be reverted. So i would
> make them a 0 byte file. You can even make it have mode 0000.

Gotcha! That seems to run counter to what the sysfs expects?

It has to have _something_ in them. But let me play around and see.

Thanks for the feedback!
> 
> However, i would first try to copy existing ideas...

Yup, lets see what the other folks have to say.
> 
> 	Andrew


Return-Path: <linux-rdma+bounces-1322-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E65818755B8
	for <lists+linux-rdma@lfdr.de>; Thu,  7 Mar 2024 19:01:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B4A3B251AC
	for <lists+linux-rdma@lfdr.de>; Thu,  7 Mar 2024 18:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5804130AE3;
	Thu,  7 Mar 2024 18:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LxZkbFty";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="iaaC7x4w"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B421BDDB;
	Thu,  7 Mar 2024 18:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709834467; cv=fail; b=bo9LrwKWBaEZE3n1MOnh2cIVu+axKhr6vfHzXyvaQ2yDs6zi12PVnccAu2QT3JIB04gQjOq0alWCioR6jh5OigtYGmmD7nrHulLismzgz/yE9syyTHW5FmLziz4qAAyr3rxqTTh0PGp68Cv/VBCWblBiGd4WXKhkSVZUoxR2iq4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709834467; c=relaxed/simple;
	bh=rcDFh3qfi8o+9HRbRNCakefXXUXQlsi4sMQU93B5PQI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tVtHILq9rDc5qql4aDwmSSbUZ6JE1vKx/JpQO95ABjpaIi0lv1NqLtUOgiVeQ0I2+b/rBU26Y0jQIIwgaNDa8aO1f2xFamzXeAqg75MIu2SdhqUwLYtjZS2quf5Vb9ehEBHEsd4dS3tXVA+Q203xdzN8VVJnz9gYE3W9z6p96Ik=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LxZkbFty; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=iaaC7x4w; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 427HQVI8026939;
	Thu, 7 Mar 2024 18:00:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=vSuvSY3fj7zY4u92zCUB+nqA0zT9YSaQ/HWbZck/HqA=;
 b=LxZkbFty0tuW83l+kI5+95K0/BIDEWbG6BzKT1CxjZ1GYIiQejzZ/cFhWzAyr8uGLRk3
 rIo+lG/PPFx9tQwyjCtFr7jao6KJE5K64pcoV07zZdX5xNFQ2aKmmMfEan6bPJ7BD3j/
 zwPOuPxwCpbZxsd3dv5q4IKfhwdBwVAYZCNP+jFt078TGdgOjlpye4wmvKzTP13Q8vWW
 nOj95XEAYbOVbwzejc2uqaAgwgbzbNOUuB4LCBtV4Yuc7EdAddBVY7dKbwZp7reWmUOT
 4CSgsp14z5s9sN8qNQw1RzJZiPo8AuVMsTV0OkopPyF5ExY4KR6Mq1XjKZEc/5qg9fo4 yQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wkv0bkyg0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 07 Mar 2024 18:00:57 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 427HpXOf013857;
	Thu, 7 Mar 2024 18:00:56 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wktjbbq9k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 07 Mar 2024 18:00:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b8swHv84C/296u5KUemCc3aBHVSZxQp4wgT0LfMaiFjav9cKqquld9Y6ffpndxOPyX5XLpycXshdcH/Ks5ReVteWjWvxy7hFxqMzVkKv2JljiUlbVawyww9TOOmDHUX5AoupoJ2hrwVKFesEW7HenP9C67y/uJrnKh8Z9dix+thJU/+c9pkghQd7CWS3AcrbOwRGVgj+u7fcr3QyY2P6MKlrrTJvXUrp9OjcJsiVpb+4jwm8jg2yoiTogP7hHDKl25xk5UXqdB2ZDz9n2WcL2NHZRJtApQSWUUiK4chebIyTja1dPrkPdoolfjvWYsaS1XEZLuOu6IFPSA1qljwT1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vSuvSY3fj7zY4u92zCUB+nqA0zT9YSaQ/HWbZck/HqA=;
 b=LQ9CY/nkU+W1K3mGEAEXiWyka8/bNC0HleMqFET5m1HD/cGMBm+XUlkYtjBqiFv/c9j+HBCciCfgh3Cvh9wyOUTceStj4bs8Db04pfX/LkDoStBziASBATXqxbXz13n7rc5ewL96VA4XBI3AwK1k7JPKixmaXg9hghg8XiDTB257TCII0BsPD9543tt8p5fRo33Pxl+bU6TYUasYMfuo4UoERvnBYyN1j6sIYDM/32lV17aRVv0FvMCBHuPu7kb8NDzk5j3Q/P24S0b+pbl9OCYljbPFUhsZpuoSgdWJwDOpWyqKt/jh8JwqMI8XeOheM+nEgfmT0LmookdzKBZrng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vSuvSY3fj7zY4u92zCUB+nqA0zT9YSaQ/HWbZck/HqA=;
 b=iaaC7x4wAvxSe8MLaVdiInQtFUdljoKcyJLZDK7waCbnYaRl2WpDublZe4HN9mNBIiHIKPKwbO9MY70Ju6E8p1s+jo/efsrWgcy2/n9eDfXLQREYQviHBk48nxSUFNNjcUdQXYgxL5FboNUrMB3eT1M8gYtAlnzGDPFsgpbVNkY=
Received: from CY5PR10MB6216.namprd10.prod.outlook.com (2603:10b6:930:43::12)
 by BN0PR10MB4952.namprd10.prod.outlook.com (2603:10b6:408:122::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.27; Thu, 7 Mar
 2024 18:00:52 +0000
Received: from CY5PR10MB6216.namprd10.prod.outlook.com
 ([fe80::34e:f5ab:6420:ca75]) by CY5PR10MB6216.namprd10.prod.outlook.com
 ([fe80::34e:f5ab:6420:ca75%6]) with mapi id 15.20.7362.024; Thu, 7 Mar 2024
 18:00:52 +0000
Message-ID: <afab7f4d-d8cd-4582-b46c-d4fa7673f429@oracle.com>
Date: Thu, 7 Mar 2024 10:00:49 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] RDMA/cm: add timeout to cm_destroy_id wait
Content-Language: en-US
To: Leon Romanovsky <leon@kernel.org>
Cc: dledford@redhat.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, rama.nichanamatlu@oracle.com
References: <20240227200017.308719-1-manjunath.b.patil@oracle.com>
 <20240303095810.GA112581@unreal>
 <8265fa8e-3de1-444e-8f58-ec60c79d6a9c@oracle.com>
 <20240307094607.GB8392@unreal>
From: Manjunath Patil <manjunath.b.patil@oracle.com>
In-Reply-To: <20240307094607.GB8392@unreal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR02CA0100.namprd02.prod.outlook.com
 (2603:10b6:208:51::41) To CY5PR10MB6216.namprd10.prod.outlook.com
 (2603:10b6:930:43::12)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR10MB6216:EE_|BN0PR10MB4952:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ba24bc0-f62f-470f-0a6b-08dc3ed08771
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	e0mUQsMepox1j2Gfu2SXDNHED3hV1ptHN5ECF79KpnOWeyBsjnwfKxpPAwfd8msBJH40SaFT3itr9jQC5be7KNDp17BEjDoTC7AH96s/b+v7yf+j+mEAXLtPgUkaRQ3RlZeUSfa1jGANG+coQp5f97qQQM9ZW5VyLeni1z10AVT9xX5+J8xdijPKP+5qhFC8buZJRNBO9TicamyIX+poH29LSdJvAYt5JF+lqIBiAm+i23OdzTjqO7g7F6sd+4EPKutUuvpxvfl4BHVZH7j7Qa8sOIzI/xExiU0DmTQtF4HVGOSq1kCd7CyHHBHEZpfXeYznvZgiuPTlQy6iICk0BZTTAGiTutZrFv3P+/qiMAlBaCBm8UvVx2WPhMxj2YEGHKbyR9bH3moKSK0MeF1mau15Ztjv+gUlbtArU17N6d58jcKtJ4zvAsyNkm62RJhbbLB/+ytkLBk2i9E1FLjdkmU0jb4pOZhNG4ycxkTldLWBIiYxxX3Q4Xf1eoMXHbPuUX7pYc/d/mNRC9RkVD6xRqmCm11rJuwm65wydLLVVj7yvqJ3y8wf/1x99L2u1gVAncLhuTuOApnOQrkqd1PA+c55d+edQfBS//uIK+4rTiY=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR10MB6216.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?bU04ZGR1dkpTZFFiVkdpSkJnVWx1NlRTSkg0WGRaT1U5MGRhRFJNQUkyOE1J?=
 =?utf-8?B?QzNwYlh5cG0wd2ZZNWZudW92dUxuZGt1TXpZVnk1L2hhT1lEdHE2Sm5pNHVP?=
 =?utf-8?B?RUpYL3RvOFJOSjMwSElKTmFiRGVkTGF3WWNpRVlqK01xdDI2NS9TVFM0VThp?=
 =?utf-8?B?cjZtNHBuZE5ZcmZsTW01QTZPb3hER09WOHpFWUszbEpzbDR1cEJycEJaeEhT?=
 =?utf-8?B?OXRxajVDQ213d3VSaUNFUmVYZVM3S1F5U0pkcldlVzZuY1NMQngwRTZpeG05?=
 =?utf-8?B?cHN3SGJkTHZlbktkK1o4Rno5Z1I1dDc1c0g3eDhySXh5bi9ZTzNLdjZoVFo3?=
 =?utf-8?B?MThUMDBDWm5abnM0c1ZCcWVhcGJEMis2V3Y4c1Y0M2FkVGFzblFSRmdvdzBL?=
 =?utf-8?B?dU1QQlVVbHRHekhZbW1uek1udnFvTFg0TU9kcGZqbjFZb0crQ2VNcFJYbk04?=
 =?utf-8?B?UmdGSGVOREpPdFhGTzFPRzl5MVl4dWczQUlrNGFYSDhYY25NMkhaK0ZyUk9S?=
 =?utf-8?B?TUt1aytDcUpPZmJFc3RpM3FBclphMEEzSWhoT080dlMxV2NqTjVBcFhOQmRY?=
 =?utf-8?B?K042b0tjSENkTjNQTGZieGlqNTJhSFRaOGFWNG1ZZmJFeG5kM2VYU1E0Wnhi?=
 =?utf-8?B?NFIzcDJHcUdleVZaekg4RkN5Q0xlWGpmc0hURVBxYzdnYzUrTTFiOTkvYWMr?=
 =?utf-8?B?WjFJb2RoSlZWTWVFVXRGd1ZCQ3hBUmFKMVArRVpaa28rd3JMSEpaK2g2TEtK?=
 =?utf-8?B?RVlqMEVxenh2VHFYSDVRQUREYU0ra3hGUG9TUWpnUW9lbk5UZFNwME53N3F4?=
 =?utf-8?B?SnFHQmJ4Z1p3UlRSWVZ6U3N4QzJYSTczOWVpS09jVVV6SGRsc0Jmb0hmUjNE?=
 =?utf-8?B?SjkwMWx4aFJzNDM5VWk0TjBSZkU0Yjg1K2E3MWRjNzJtbGhOK0pvRFppY3l6?=
 =?utf-8?B?VU02QmtnWWduN1lHSWc2eXFoYUk1SUF0UGltSE9QWDlha2ZCb3NxajZORDFq?=
 =?utf-8?B?czhRU0RsdXEveVdpejhVSXJ4MXBoSnpBN2ZDRlp3d0pvMnB6LzZPTE5GVEZ6?=
 =?utf-8?B?M253Uk13cy9pNVNRWjQydFJjNkhvNDVCSDRTTjFGRlZ0RU8yK3oxTnZ5VGlt?=
 =?utf-8?B?OEdadHJWd21lOVNWL0VsTHcvYWorNXZiY2dlZzg5Vkp3VThvbkRhWDVrYVVL?=
 =?utf-8?B?cU5WK0czTXN6RG1YcUJkdXdEM1lJU3FRT1ZBYmNVdFB6QXQ4bkZkYnVuZjlG?=
 =?utf-8?B?dkR3blZZSE14ZjdPL3UwYk5nTlVKYlJMWHozOU5ZL1hSb1ExQ2s1aW5pRWZi?=
 =?utf-8?B?RXJNNnppWHB2NlhJWG8rRkRjSHZZR0lrL2ZCSDhQUDVjd2xrVjBZbWc5WjFk?=
 =?utf-8?B?UUUwZEZ4SW9oYjZXVWVpaTd5NmxHeWgzUlpVL3ptR0V3MkhBeTcyR21DL1Za?=
 =?utf-8?B?Wkw1cUJJeUZXMytWcllIUGlzK0lSVGlKRmh0K3RSd2hHK1V0akFlU3VxUVlE?=
 =?utf-8?B?TFBRMDlQL0Z0UFBJdWRvQWFJbzdKMitIU1gvL0ZqeDRVZERDcWdoMVQrNTVo?=
 =?utf-8?B?WFBNOEgweFFzV2laWHRhNXJpTSt2Q0YzU2FZTGhaV1RQTE4wRlg1dkZ1ZmJY?=
 =?utf-8?B?M0tKZmlXcVZaUXpFNWkxaW9qZCs5NmlTbUs4cmZBYlYrcjRvdWhJWHVUMXRw?=
 =?utf-8?B?bnMzY1hRNGtYS2tRQjlUWi9zTllYcFN0dDBod1JzeUFTSVQzRE5yY1lhdnk0?=
 =?utf-8?B?UkpWRnp2aTJkTzJ6UXpvczRRL1BEN3hwTkRud0ZHTFRoK3plK0FqNU85Y1pI?=
 =?utf-8?B?Mk9ob29aYlh5VEdMbGpZMEltV2IxZngrK2FBZEpEN1lRWEZ1a0hpZ0c4MVFC?=
 =?utf-8?B?VUFUdTdJTXloWXB5MjBMb0dTYXN3a2tBa2YrbUYwblZmQXRKNXd1UUV1eXFq?=
 =?utf-8?B?OTFQcVFUS0EwQkI2TXVEcWtvQWMwQ0k4K0JnL1FUZ2FEdjUvc1FqOTY4OS8r?=
 =?utf-8?B?YnNUTkEwZFpEdnBEL092bmdHUlVMNjBtWG5odkJqSU5kSndYbGpRSUNaYk1h?=
 =?utf-8?B?VDdDUkFTZDUvM1lKZGpMT3BwbkluQUErV0xDc29yZGRZeE9xOXlwNEd2THlI?=
 =?utf-8?B?ZGpJMW1PUGNUSkdvZW1zYk1UdUN2SXBxOGppSDVrbmU3amMrY252bW5BQVZv?=
 =?utf-8?B?WGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	CnABKhD4hrxZDN4lyhbkQYzyq1TE+Gj4S3O66lPZorgFHi/VogBUJdWjNLvsO//I7ycaNmaIXuygzvV8q/sbXDfUCVTUf5MeAH2hmspiXJ73rVJ6fz19GqTWvgtgnyPzo4PYPO6UuH/anlGKEjNHa1TbAFIJiXjHUgw8uwKdMYQDwMSEecd1tn26rwJDWENRDi2HIVBOUSnM05qKPdA31HFtj53QqfAlobF4DRaIisFoZr6p1m3RhcOOABbjO1h72TrZMV9dmi4zFO7dJXcJMII72ucJxxNzFTgH1LaOt/nsWqZ9SJeh4eXhUCrXpJjXKYyeyA4l8n7vYTXAo2Efr/EtKmn/sG5IfNG1dnnSOLerVODefiqCkeBv+NsTSGS9Zys3FBTDeznTrOlQPCCSYDi3PE1PKXmAB2xkzrcjO8mOJ8UTXYA7ZEaCTHx9bs//FOuznRhR4CI32Lh++OsbJNjTJRi61bwmj0+aM/0AGouc4OBIM7Sn/P2b9D7PfepZdue8owaDI8aGePoNuymCHGrgOmvHMhMM2waAyKH27pLDWc7/xnNC3Cplrjief85K5WkowgePxOFs6wUNGJXDR1czhHwNQNZdTLM0i3aSMfU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ba24bc0-f62f-470f-0a6b-08dc3ed08771
X-MS-Exchange-CrossTenant-AuthSource: CY5PR10MB6216.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2024 18:00:52.8129
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ymaqP09IlOkQ3TfI6iSm2bsNk5Mqx8/BnbVkUCV8X0okH+C5P6GgJPBKffoHQvud/pkNBJLEI2U3wiGxyPsf2Mdi7GyQmx+nn93TuY8tMlg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4952
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-07_14,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 spamscore=0 phishscore=0 suspectscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2403070124
X-Proofpoint-ORIG-GUID: 2sNgVSw1oPbehungf6Q7057XSk_W4074
X-Proofpoint-GUID: 2sNgVSw1oPbehungf6Q7057XSk_W4074


On 3/7/24 1:46 AM, Leon Romanovsky wrote:
> On Tue, Mar 05, 2024 at 02:59:11PM -0800, Manjunath Patil wrote:
>>
>>
>> On 3/3/24 1:58 AM, Leon Romanovsky wrote:
>>> On Tue, Feb 27, 2024 at 12:00:17PM -0800, Manjunath Patil wrote:
>>>> Add timeout to cm_destroy_id, so that userspace can trigger any data
>>>> collection that would help in analyzing the cause of delay in destroying
>>>> the cm_id.
>>>
>>> Why doesn't rdmatool resource cm_id dump help to see stalled cm_ids?
>> Wouldn't this require us to know cm_id before hand?
>>
>> I am unfamiliar with rdmatool. Can you explain how I use it to detect a stalled connection?
> 
> Please see it if it can help:
> https://urldefense.com/v3/__https://www.man7.org/linux/man-pages/man8/rdma-resource.8.html__;!!ACWV5N9M2RV99hQ!K0TW8CNb7aCJsJbLV7Uhy9K_rOdMuHsHoUki2GIaxxQt0hd31pUCi9FeGMx2hTNI0j48ju1D6KiIrDNJ254$
> rdma resource show cm_id ...
> 
Thank you for the reference. I will go through it.
>> I wouldn't know cm_id before hand to track it to see if that is stalled.
>>
>> My intention is to have a script monitor for stalled connections[Ex: one of my connections was stuck in destroying it's cm_id] and trigger things like firmware dumps, enable more logging in related modules, crash node if this takes longer than few minutes etc.
>>
>> The current logic is to, have this timeout trigger a function(which is traceable with ebpf/dtrace) in error path, if more than expected time is spent is destroying the cm_id.
> 
> I'm not against the idea to warn about stalled destroy_id, I'm against
> adding new knob to control this timeout.
> 
Thank you for sharing this. Adding sysctl isn't critical for me. I am happy to get rid of it.
I will send a v2 with control knob removed.

-Thanks,
Manjunath
> Thanks
> 
>>
>> -Thank you,
>> Manjunath
>>>
>>> Thanks
>>>
>>>>
>>>> New noinline function helps dtrace/ebpf programs to hook on to it.
>>>> Existing functionality isn't changed except triggering a probe-able new
>>>> function at every timeout interval.
>>>>
>>>> We have seen cases where CM messages stuck with MAD layer (either due to
>>>> software bug or faulty HCA), leading to cm_id getting stuck in the
>>>> following call stack. This patch helps in resolving such issues faster.
>>>>
>>>> kernel: ... INFO: task XXXX:56778 blocked for more than 120 seconds.
>>>> ...
>>>> 	Call Trace:
>>>> 	__schedule+0x2bc/0x895
>>>> 	schedule+0x36/0x7c
>>>> 	schedule_timeout+0x1f6/0x31f
>>>>    	? __slab_free+0x19c/0x2ba
>>>> 	wait_for_completion+0x12b/0x18a
>>>> 	? wake_up_q+0x80/0x73
>>>> 	cm_destroy_id+0x345/0x610 [ib_cm]
>>>> 	ib_destroy_cm_id+0x10/0x20 [ib_cm]
>>>> 	rdma_destroy_id+0xa8/0x300 [rdma_cm]
>>>> 	ucma_destroy_id+0x13e/0x190 [rdma_ucm]
>>>> 	ucma_write+0xe0/0x160 [rdma_ucm]
>>>> 	__vfs_write+0x3a/0x16d
>>>> 	vfs_write+0xb2/0x1a1
>>>> 	? syscall_trace_enter+0x1ce/0x2b8
>>>> 	SyS_write+0x5c/0xd3
>>>> 	do_syscall_64+0x79/0x1b9
>>>> 	entry_SYSCALL_64_after_hwframe+0x16d/0x0
>>>>
>>>> Signed-off-by: Manjunath Patil <manjunath.b.patil@oracle.com>
>>>> ---
>>>>    drivers/infiniband/core/cm.c | 38 +++++++++++++++++++++++++++++++++++-
>>>>    1 file changed, 37 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
>>>> index ff58058aeadc..03f7b80efa77 100644
>>>> --- a/drivers/infiniband/core/cm.c
>>>> +++ b/drivers/infiniband/core/cm.c
>>>> @@ -34,6 +34,20 @@ MODULE_AUTHOR("Sean Hefty");
>>>>    MODULE_DESCRIPTION("InfiniBand CM");
>>>>    MODULE_LICENSE("Dual BSD/GPL");
>>>> +static unsigned long cm_destroy_id_wait_timeout_sec = 10;
>>>> +
>>>> +static struct ctl_table_header *cm_ctl_table_header;
>>>> +static struct ctl_table cm_ctl_table[] = {
>>>> +	{
>>>> +		.procname	= "destroy_id_wait_timeout_sec",
>>>> +		.data		= &cm_destroy_id_wait_timeout_sec,
>>>> +		.maxlen		= sizeof(cm_destroy_id_wait_timeout_sec),
>>>> +		.mode		= 0644,
>>>> +		.proc_handler	= proc_doulongvec_minmax,
>>>> +	},
>>>> +	{ }
>>>> +};
>>>> +
>>>>    static const char * const ibcm_rej_reason_strs[] = {
>>>>    	[IB_CM_REJ_NO_QP]			= "no QP",
>>>>    	[IB_CM_REJ_NO_EEC]			= "no EEC",
>>>> @@ -1025,10 +1039,20 @@ static void cm_reset_to_idle(struct cm_id_private *cm_id_priv)
>>>>    	}
>>>>    }
>>>> +static noinline void cm_destroy_id_wait_timeout(struct ib_cm_id *cm_id)
>>>> +{
>>>> +	struct cm_id_private *cm_id_priv;
>>>> +
>>>> +	cm_id_priv = container_of(cm_id, struct cm_id_private, id);
>>>> +	pr_err("%s: cm_id=%p timed out. state=%d refcnt=%d\n", __func__,
>>>> +	       cm_id, cm_id->state, refcount_read(&cm_id_priv->refcount));
>>>> +}
>>>> +
>>>>    static void cm_destroy_id(struct ib_cm_id *cm_id, int err)
>>>>    {
>>>>    	struct cm_id_private *cm_id_priv;
>>>>    	struct cm_work *work;
>>>> +	int ret;
>>>>    	cm_id_priv = container_of(cm_id, struct cm_id_private, id);
>>>>    	spin_lock_irq(&cm_id_priv->lock);
>>>> @@ -1135,7 +1159,14 @@ static void cm_destroy_id(struct ib_cm_id *cm_id, int err)
>>>>    	xa_erase(&cm.local_id_table, cm_local_id(cm_id->local_id));
>>>>    	cm_deref_id(cm_id_priv);
>>>> -	wait_for_completion(&cm_id_priv->comp);
>>>> +	do {
>>>> +		ret = wait_for_completion_timeout(&cm_id_priv->comp,
>>>> +						  msecs_to_jiffies(
>>>> +				cm_destroy_id_wait_timeout_sec * 1000));
>>>> +		if (!ret) /* timeout happened */
>>>> +			cm_destroy_id_wait_timeout(cm_id);
>>>> +	} while (!ret);
>>>> +
>>>>    	while ((work = cm_dequeue_work(cm_id_priv)) != NULL)
>>>>    		cm_free_work(work);
>>>> @@ -4505,6 +4536,10 @@ static int __init ib_cm_init(void)
>>>>    	ret = ib_register_client(&cm_client);
>>>>    	if (ret)
>>>>    		goto error3;
>>>> +	cm_ctl_table_header = register_net_sysctl(&init_net,
>>>> +						  "net/ib_cm", cm_ctl_table);
>>>> +	if (!cm_ctl_table_header)
>>>> +		pr_warn("ib_cm: couldn't register sysctl path, using default values\n");
>>>>    	return 0;
>>>>    error3:
>>>> @@ -4522,6 +4557,7 @@ static void __exit ib_cm_cleanup(void)
>>>>    		cancel_delayed_work(&timewait_info->work.work);
>>>>    	spin_unlock_irq(&cm.lock);
>>>> +	unregister_net_sysctl_table(cm_ctl_table_header);
>>>>    	ib_unregister_client(&cm_client);
>>>>    	destroy_workqueue(cm.wq);
>>>> -- 
>>>> 2.31.1
>>>>
>>>>


Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1577B6AE802
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Mar 2023 18:12:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230515AbjCGRME (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 7 Mar 2023 12:12:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229951AbjCGRLb (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 7 Mar 2023 12:11:31 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31A1C2D15E;
        Tue,  7 Mar 2023 09:06:19 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 327GwoMi026626;
        Tue, 7 Mar 2023 17:05:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=hlHCELbRJ8iby15hyQ82IwhV6gHaj8NWf13iGPAKzAg=;
 b=v580EbHFZLzqvr60CY6PY2u201t2fRO8OzS6yP3Unl89VD4SbrpWQuCW8NQoCEoJKL9R
 JpNAaFAyhl74iZ8uJB5tKyAhwjX71k4kyj7MPPSqDK8K2pa1LzW50QcL+9WZ3cRdi/eo
 p0mf3Cwnh5OewY2D9YTQnaPN6M3z/I/o5LAU7o9tQLnf6AqEchGqCJCSeZfggWcqN5AA
 /h4Tph7q1n8y9tckGU4hsmMkSvzz/BfV5UKIZ3CV2KTk7JH8xRHSci355w0nZGSU1xP4
 GYXS4hi8SNL6XL2op88MNSdzBGJjML7OpM3h5s77espurG/5QRrFXRD04U+qAI2fbHKh lg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3p4168p1ug-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Mar 2023 17:05:21 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 327GRxbK025835;
        Tue, 7 Mar 2023 17:05:20 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2048.outbound.protection.outlook.com [104.47.74.48])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3p4ttk9nds-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Mar 2023 17:05:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c5uUgXxp/ZXrIURAiBnSP54ae7MFcnuOXzKsUV/xmnixI1sgQIlAceML9MibOgrjj9W4GNq3X4n/g4oe52dx8UxZ0pwq6KLvBZzXbGu9gr7YqqWMKncyxw9lnBeiNzCO4wOTCwAZJrzoFArbJqvjbka744lVRTBenr6abwdXyDG8LaLj4PIY1ccWJymtZsMzadSARanus5RW//5wvo7Ae7mRZlqnX81mQ7OSfVJcACkwCW+phH41afDs+7S1Js8hHBjwciJ1KRoQzdJeM6GoViBqK0BVis5j900hhLE9DxfCLfuV/4cvPJpYHIjadzwF8dNn9bDWhM68/pqI3O14KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hlHCELbRJ8iby15hyQ82IwhV6gHaj8NWf13iGPAKzAg=;
 b=C5EN+B+uhxVWHw+Vk1uBoyN0sN6l4iLdRPJlwChrkNfWuWPVbMgkU+NCNYACo1i6FhqdCSj/xTOtZKHNvjDW7isGZNyXUB9dNWiRTAtekiwgrXDuSSX4wTUhQFWLg3JnMqD6o5By96zhH5CWwkLMGKP7OlYvMWDeQsdpT4TGQj60fHojmFWP7UZJRo3F3RqTXG9EiZda1Q8rNjPqA6df2/VY5wo4Z9su1hwPUGIdNcqFOe5AHiK2M13bNB8AqlPXg2yfnXEevbFYODuRaqoJo2J5K7vi2hhmu58Xdgucb2kIxorSee3zS69czTkrp7ju3/VZcU2BB5wFSmsk1JiMEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hlHCELbRJ8iby15hyQ82IwhV6gHaj8NWf13iGPAKzAg=;
 b=io6ocvYZ1Ojfy/xdcqihb17/Vw9+wYybieB1H4yr3PGpv9Xeq9CCs7wAqGVOuLfeEx8DzL1Xic7z0eVAxlVwD5XrioiKucVwthhimn3zPutNCYnmpcZScl5YW7cG8PKG3fn5yFY/q2UpN5vhy1OAXBy0ODvgBZBW+C3dU1a4FDM=
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 SJ0PR10MB4622.namprd10.prod.outlook.com (2603:10b6:a03:2d6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.29; Tue, 7 Mar
 2023 17:05:09 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::7dd7:8d22:104:8d64]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::7dd7:8d22:104:8d64%7]) with mapi id 15.20.6156.028; Tue, 7 Mar 2023
 17:05:09 +0000
Message-ID: <238afac0-657b-d2e0-8de6-88a59ee9b2e4@oracle.com>
Date:   Tue, 7 Mar 2023 11:05:07 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH for-rc] IB/isert: Fix hang in iscsit_wait_for_tag
To:     Sagi Grimberg <sagi@grimberg.me>,
        "Saleem, Shiraz" <shiraz.saleem@intel.com>,
        "Devale, Sindhu" <sindhu.devale@intel.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>
Cc:     "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "devel@vger.kernel.org" <devel@vger.kernel.org>,
        "Ismail, Mustafa" <mustafa.ismail@intel.com>,
        "Marciniszyn, Mike" <mike.marciniszyn@intel.com>,
        "target-devel@vger.kernel.org" <target-devel@vger.kernel.org>
References: <20230119210659.1871-1-shiraz.saleem@intel.com>
 <909684d4-f169-792b-7f84-ba18a6e19824@grimberg.me>
 <SA2PR11MB495347CE35C9ED97CD80C422F3CC9@SA2PR11MB4953.namprd11.prod.outlook.com>
 <SA2PR11MB4953D102791B458434A775FDF3D39@SA2PR11MB4953.namprd11.prod.outlook.com>
 <4df68538-6027-712b-8dac-e089d6f2192d@grimberg.me>
 <MWHPR11MB00294E08888B739ADB064BC2E9B79@MWHPR11MB0029.namprd11.prod.outlook.com>
 <0731e4a4-0683-0b36-a0b7-a3e7fecf0e70@grimberg.me>
Content-Language: en-US
From:   Mike Christie <michael.christie@oracle.com>
In-Reply-To: <0731e4a4-0683-0b36-a0b7-a3e7fecf0e70@grimberg.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR05CA0051.namprd05.prod.outlook.com
 (2603:10b6:610:38::28) To DM5PR10MB1466.namprd10.prod.outlook.com
 (2603:10b6:3:b::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR10MB1466:EE_|SJ0PR10MB4622:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bf46c4c-dba2-4bdf-2174-08db1f2e1b6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1MXq5lmpkkz1OJUSA8NMWJtKF1YYmuMlwHXh4AdlwDFtHvpL9LHch2Cdbc9kpQ9pECsi1JXkcS/Mnvgg5aMrw9n35kE4yRXCqxLGJasR6UQ4Di/7HQuP0Z4FWWJsobx4xHeN4LLkdnPIJVyChUGcvuIQAqJjnkgGzq7Fa3flNdq36dqDDEqNpeXTzgUsD9HViddfekKhqSbLd7LxZrKv/1FoS913JzUyrLCeQ60DxPVzCd8m1Ws3J4l63syjr7UuHpvZaeWkagbN2kuq/OR+gQazhQuJNgWwgj8yymEUcCkz14XTfNjYVvgKL0F3WiriBcBL/592BXO4S0vbhlRzWP2rrAA01JCNqm8Ciz4n4/aMnCOWAyxbc0NGu1NTceQF1UrA4akb2Thy9XdcI39sXjD41jcb1sZtRYBqhBw/HOC8Yr3Ms3l1iOM+RJOcKJagYfSp6emSNQLZYsFeMkYujk4Ew2Lm8xk1JRdXkV2qlxhOg7jHTHGJUxB3mGVhHh1N9F0/+c3AwKpe9MFO7UCNv4T/2HljAQYklTRjrrvdrA4JupWMY2F/XwCokuWKZtjAlg7wc5GxngU5SpC+1/EaK9+HBMQPFLmD88DAZA7jYKDttGzUEzJPG3lPM/f10y8fhL61TiLHiDY6HgX/RrRGNNH0fNHzCOiL0cWZsw98OzAi/rJ6sqpR3e4t5abExv0dKAvOIndZetXjT7PdO884poyvm4Dmzfj/ziM5MAWv7Kg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR10MB1466.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(136003)(346002)(366004)(376002)(39860400002)(451199018)(36756003)(31696002)(86362001)(8676002)(66946007)(66476007)(66556008)(41300700001)(5660300002)(4326008)(6486002)(478600001)(54906003)(966005)(110136005)(316002)(7416002)(2906002)(8936002)(38100700002)(53546011)(6512007)(6506007)(26005)(2616005)(83380400001)(186003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TCtDWFdZTGhBQmw1NVpTY2VFNDZCNFZLdXhxRUxMR2dCeTIwWDJDUG9RU3NN?=
 =?utf-8?B?NWdObmFseHdXY084aGEyT2dDNCt4U0pwNmRnS0pYU2dOalhjM2gycWIrOXpV?=
 =?utf-8?B?b3dIREhINGd1cXhqR3FETVh2Uk5CV2lZWTFxR0R6emMxc3pQVlNBbU9WQzZF?=
 =?utf-8?B?c0NwU1l0TFl6Zit4TEdaUEtIWTRYUjVjZVFPSmk5ZlFLcXBtT2tRSEhqd1pr?=
 =?utf-8?B?RG9uS1ZhRjNLMDdYM05xcE1SQm5FUTUxMktCR0gxM0o1dDVtOVY4V3NiTTNL?=
 =?utf-8?B?dVMvNlJPZXRpcGJiWjF5blI0aGNsbUtzdElZVFhIa3ZUMXpqbm1HRi81bFYr?=
 =?utf-8?B?cktJalNYYnZ0cHRQcklicHlBV2MrbnRnWiswb3VFRkl6RTlxV0cxL0VwWmFF?=
 =?utf-8?B?N1l5dFV3dkNDaHZDN1NWQUNDSHZIdGwyQVV2N0RCamZIa05nb0x6cCtHblRM?=
 =?utf-8?B?RXVtTnZhNjNmbnFSZE5KUG9RdGhmV3NjYjNiSE04L0F0Snk0V1FNY2xGNERq?=
 =?utf-8?B?Z01kZUN3UnpUVzBaRy83WWd5YlVKd3RhdkV0ZUhGaVVNRkhUZWJVNmxCZ2Qr?=
 =?utf-8?B?NlBCRXVOSFNiYXY5K2pOUGl0aCttTi9aTlFGL1ByaE53Z0VuYXBPNDJiZm94?=
 =?utf-8?B?U1ZVSElIYWc0UmZ1L0pZaUJrcXNHVFJTMWMvekZqekxFTTZRcGhidUlzN25y?=
 =?utf-8?B?Q3MvY3hWL3VwbTM4OUFnU2dvelhrMllNajFwVlRjNmJ4OUFmNjk5cHhvd0lX?=
 =?utf-8?B?RmJIUEVSVUdBTzIrNlBNaGFEbXZlOWh3QXRrKzBPeXljZzFTdktWWHk4Nzlk?=
 =?utf-8?B?azJYakkwa2hLOC96R0ZHa24yTWVuNjVnU2NKSE9BNy9XNHp1SmhXWWJuZDRW?=
 =?utf-8?B?RFdyRGhXZFFPUTZLRkxWUnExb3NERjJGcmhkZ0pHVk11bFV6Zm0vUTVzOEl3?=
 =?utf-8?B?Q0o5U3B4a1dKOWZVZGZHczFlelFYdUlDVlZHNllwYWVvd21mNDJVQTYwbjdN?=
 =?utf-8?B?aWtjWHFmVU5ocm84UWlJWHc1YkR3Nmp5UlhnTkNuOStGN1EzRUNJSzcycUxT?=
 =?utf-8?B?c2wwWk5mc1R5T1pOcjhCL0h3MFJPNTY4SWNIWVRJRS9Wdmh1SW9YYWVwVTBZ?=
 =?utf-8?B?NjIwak9wL3BPNlp1b1g4TkVWM2txOE53VUFweWdiSTBTdndlSnloM0Vhak9l?=
 =?utf-8?B?SXZmNDhxRzBiYTZyb050MXFhWnNPM3ZqREh3S3ZzakhCWStFQkk0aVB5eGpx?=
 =?utf-8?B?a3NoVUZyNnFKZlFqNTgvVVEvQXJzaFpXTGlMdGwxai8waTRzM1QyZmdEeXcx?=
 =?utf-8?B?aDdlNzJ1ZWdIWVRuU2RURlpXYUszMGgxZ0hFNDZqbWM1b0xNN1hWUlFEeVVk?=
 =?utf-8?B?K042ZDB3emNsdEtnd1dsT1FET29EQkNyZG5MV0JLaFNWRk5kMHJkcjRQaHVO?=
 =?utf-8?B?MmxwSWVVRkhPekU0NTVPR2NjeGlMVWJvOXhXdDVtYjdndmliaHkvTGtMQ2tQ?=
 =?utf-8?B?czd6RFJINFhvOEF2K1E3TVZFcFhSZ1pQSGtkZUlRNngwYXBFbXJUOGtET0JS?=
 =?utf-8?B?K2FYdVZVbHg4OUpMaHpGUTlnUzB4VDE0K05ObkE3ZnlPUjNwTkY2T0RQTU5T?=
 =?utf-8?B?K3lCSER2T1N0VUI3WFJESXd6bVVBc2RxK3NUKzdjLzlVSlpHMkE5eitTYThT?=
 =?utf-8?B?U2hnRUVabTJjQjJYTC9yZ2dPcW5ua05PaDl0RnNmZElvVUZvUHYvbWhXK0VW?=
 =?utf-8?B?NzVoSTJNK0R1MlA1YUkwMkh4ckdKM1lwUkNuMG5RR0RBYlNsNkt0YklCdU11?=
 =?utf-8?B?Qm1CVXRWNjlXQjdhcVVKK2NIaGFoelEvOE5CbzQ2aEcxMzVkemh4SFNDdkpv?=
 =?utf-8?B?dHNnQkRscnRpeEhLa2phQXdSQ2FwYU1PSDFXRzZ3VDdNbndianExcVpYeUNE?=
 =?utf-8?B?ZTh3am02TmNUK1kxRlkzMEl2cmdOZGIzaGp2aHV2d3J5V01HZWxkTjM0QlIz?=
 =?utf-8?B?TnFONFVXNUtzemxlTVd3VWZXUDQvbGVlQ2k0N2dkZTBDd1EyUWM2cHVwUFlW?=
 =?utf-8?B?ZjlVZ080TVdhZ1dXTVFOWTc2YTB5a0tWZ011TWZuSVhGZWZucElBQ0VGcjdG?=
 =?utf-8?B?amhsWWhxbEJnMHBrTU1Jalc0c3N1d1NNWlVTVG91aXlmTFVxWFp6SlF6dWx3?=
 =?utf-8?B?aUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: RXC/OftWfa86CnfyYTTrWLUAwxWyNwVQUInt4eYZO36Aod/moYFIkQ2zzR7j5mJGQ1YRn5Cr1BBQ3w/DHkDbT38+mGjzsR4oDCN35Va5CqP6NasS9HJwNv93n/z2xah/CDqD8Kw+BwoIMlTikJ+RSqOkdF8ulJD0A2OlrVkrd1M65t/zXkT2ytQ5PJruMYHUj79D0PfiEsMGvtdOnGo9HTzGzOxu79FY26Lpm1kzQfjhPaQ1A4m7mA9v2jzgPYcq5mIJGZU/rsWcbiOUB9Itt8mgRSlFdIgxms+iMolqLeiBITpne9+kpQu0QmQC8WMkgip1Zr4xuSWpD4An1nQjFwuGGJTrDYUtIFF4WqqjJwQNK7fJL5CEWm/OWTjFQwZC7KC7cl69W+wawRwCx9ATBos0XWuTh174ueWTI5TIjnPS91+C0wTQ1LnWpwaPT23GVqBRAJHdfCd091lFu0BOh1ahABEvEmZ4PxSGoJtfbbfH5elCQJAHhCvbAJGDWbonG0TMN4hPTaaT1Asnp0stK5kc9rAH+xRPgNJdt87d1DJktykEzC5eJizqMbKIJp8DzUEdqityPJ+gQZsRgfoChFDNbyMrUK22NSnjfxPl3FmDLjG2cKH8yLu8RII3KvNXQtHXkhALYt57qPCl815Kv2lniUtmOQZZFIlY6V2SvFlwT4V3OOjPIBaqU57DvNHdf8ri5NigdIY4+Gy5ZV2C21vTf4l2y6aiQ0Cuh1Ph29ZZFQAdWAhKdc9tkqMml3NDtcIKdi3qH19Sgxz/FeyIU0sWsevNV0l5hbyFuAa7BdD3EIGcJeT4gdmQUBlmyLhiSMEpulp8pq0hdeGzWPpKihcgHMMSWJ7Y1ai87+OCN3z4ccGYCD+nFxtCo/T27CXe
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bf46c4c-dba2-4bdf-2174-08db1f2e1b6b
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2023 17:05:09.3113
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NdolshzFI+DRPrS0VKtqIY27NOqzIGQguNDIqqoIbxmM8Hpj4qR+JqqBZd2sFfzW3F7cKSypfxOGBXgdWsEFc9H/SepvyCSiKCoBuHRn3BQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4622
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-07_12,2023-03-07_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 malwarescore=0
 mlxlogscore=941 bulkscore=0 mlxscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303070153
X-Proofpoint-GUID: sxETzwR0G2KkTXzZbjeMjfuzT9KNPTTY
X-Proofpoint-ORIG-GUID: sxETzwR0G2KkTXzZbjeMjfuzT9KNPTTY
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 3/7/23 5:47 AM, Sagi Grimberg wrote:
>> [  220.131709] isert: isert_allocate_cmd: Unable to allocate iscsit_cmd + isert_cmd
>> [  220.131712] isert: isert_allocate_cmd: Unable to allocate iscsit_cmd + isert_cmd
>> [  280.862544] ABORT_TASK: Found referenced iSCSI task_tag: 70
>> [  313.265156] iSCSI Login timeout on Network Portal 5.1.1.21:3260
>> [  334.769268] INFO: task kworker/32:3:1285 blocked for more than 30 seconds.
>> [  334.769272]       Tainted: G           OE      6.2.0-rc3 #6
>> [  334.769274] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>> [  334.769275] task:kworker/32:3    state:D stack:0     pid:1285  ppid:2      flags:0x00004000
>> [  334.769279] Workqueue: events target_tmr_work [target_core_mod]
>> [  334.769307] Call Trace:
>> [  334.769308]  <TASK>
>> [  334.769310]  __schedule+0x318/0xa30
>> [  334.769316]  ? _prb_read_valid+0x22e/0x2b0
>> [  334.769319]  ? __pfx_schedule_timeout+0x10/0x10
>> [  334.769322]  ? __wait_for_common+0xd3/0x1e0
>> [  334.769323]  schedule+0x57/0xd0
>> [  334.769325]  schedule_timeout+0x273/0x320
>> [  334.769327]  ? __irq_work_queue_local+0x39/0x80
>> [  334.769330]  ? irq_work_queue+0x3f/0x60
>> [  334.769332]  ? __pfx_schedule_timeout+0x10/0x10
>> [  334.769333]  __wait_for_common+0xf9/0x1e0
>> [  334.769335]  target_put_cmd_and_wait+0x59/0x80 [target_core_mod]
>> [  334.769351]  core_tmr_abort_task.cold.8+0x187/0x202 [target_core_mod]
>> [  334.769369]  target_tmr_work+0xa1/0x110 [target_core_mod]
>> [  334.769384]  process_one_work+0x1b0/0x390
>> [  334.769387]  worker_thread+0x40/0x380
>> [  334.769389]  ? __pfx_worker_thread+0x10/0x10
>> [  334.769391]  kthread+0xfa/0x120
>> [  334.769393]  ? __pfx_kthread+0x10/0x10
>> [  334.769395]  ret_from_fork+0x29/0x50
>> [  334.769399]  </TASK>
>> [  334.769442] INFO: task iscsi_np:5337 blocked for more than 30 seconds.
>> [  334.769444]       Tainted: G           OE      6.2.0-rc3 #6
>> [  334.769444] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>> [  334.769445] task:iscsi_np        state:D stack:0     pid:5337  ppid:2      flags:0x00004004
>> [  334.769447] Call Trace:
>> [  334.769447]  <TASK>
>> [  334.769448]  __schedule+0x318/0xa30
>> [  334.769451]  ? __pfx_schedule_timeout+0x10/0x10
>> [  334.769453]  ? __wait_for_common+0xd3/0x1e0
>> [  334.769454]  schedule+0x57/0xd0
>> [  334.769456]  schedule_timeout+0x273/0x320
>> [  334.769459]  ? iscsi_update_param_value+0x27/0x70 [iscsi_target_mod]
>> [  334.769476]  ? __kmalloc_node_track_caller+0x52/0x130
>> [  334.769478]  ? __pfx_schedule_timeout+0x10/0x10
>> [  334.769480]  __wait_for_common+0xf9/0x1e0
>> [  334.769481]  iscsi_check_for_session_reinstatement+0x1e8/0x280 [iscsi_target_mod]

The hang here might be this issue:

https://lore.kernel.org/linux-scsi/c1a395a3-74e2-c77f-c8e6-1cade30dfac6@oracle.com/T/#mdb29702f7c345eb7e3631d58e3ac7fac26e15fee

That version had some bugs, so I'm working on a new version.


>> [  334.769496]  iscsi_target_do_login+0x23b/0x570 [iscsi_target_mod]
>> [  334.769508]  iscsi_target_start_negotiation+0x55/0xc0 [iscsi_target_mod]
>> [  334.769519]  iscsi_target_login_thread+0x675/0xeb0 [iscsi_target_mod]
>> [  334.769531]  ? __pfx_iscsi_target_login_thread+0x10/0x10 [iscsi_target_mod]
>> [  334.769541]  kthread+0xfa/0x120
>> [  334.769543]  ? __pfx_kthread+0x10/0x10
>> [  334.769544]  ret_from_fork+0x29/0x50
>> [  334.769547]  </TASK>
>>
>>
>> [  185.734571] isert: isert_allocate_cmd: Unable to allocate iscsit_cmd + isert_cmd
>> [  246.032360] ABORT_TASK: Found referenced iSCSI task_tag: 75

Or, if there is only one session, then LIO might be waiting for commands to complete
before allowing a new login.

Or, it could be a combo of both.


>> [  278.442726] iSCSI Login timeout on Network Portal 5.1.1.21:3260
>>
>>
>> By the way increasing tag_num in iscsi_target_locate_portal() will also avoid the issue"
>>
>> Any thoughts on what could be causing this hang?
> 
> I know that Mike just did a set of fixes on the session teardown area...
> Perhaps you should try with the patchset "target: TMF and recovery
> fixes" applied?


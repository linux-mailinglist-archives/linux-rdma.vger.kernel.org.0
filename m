Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42505782E60
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Aug 2023 18:25:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235711AbjHUQZt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 21 Aug 2023 12:25:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232526AbjHUQZt (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 21 Aug 2023 12:25:49 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5794F3;
        Mon, 21 Aug 2023 09:25:47 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37LFxqxF024095;
        Mon, 21 Aug 2023 16:25:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=+D5gU3o5wu0DXf+jmpJf+qx8X/yOh7mj1A5yJ7lhNUA=;
 b=gENWYGvFdXaPjk82InY7/n61xvh4zsBd10AotUhEKsd+9GhCHd5s+QFOfb6PyGqbm9+0
 DEl59g8JxT7Tn5H51QTFCABQsqQhUh3p9QFQiB/iKFKWwjk/Wm1HxqJHLrV6ZOl4YTj3
 Ro4LUbkj4B9n0IsTM5mFrs+nvXvdhZuRIhRNa3VXLHSqwe96Br4Y/5zmuRWAWl+r+bAJ
 T/bhyWG6nCkvW7h2nTcXKZy1NGCB0lIrTRPflMzfzPdEgSes75SdkYS7Q4sjaAlIrGZi
 Sj3cMb30PnB/+chZTjs6sByM0q/VZfH944Qf2Q9EYHS7Yf5ThHIHFbrphMv0mW7qKThs 2g== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sjnma38a2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Aug 2023 16:25:40 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37LFBQxS026676;
        Mon, 21 Aug 2023 16:25:39 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2040.outbound.protection.outlook.com [104.47.57.40])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3sjm63wq9c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Aug 2023 16:25:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jL+FGXTCUIeHAatmiwTM/+dkillFoFbzhLQhwlbwSs2z0JAJrAahLnGpyprxqqxwy4wZK4gVzEbf+mTskdH6RUsJos8RoVnhNXdwJ+9eBBHYFhcJe7arj9RGPXS5STSRttqE8DejAy2ydJ28xbIo2vfiE/AeXHw/utGmyFsV6nhru3bVwu0RzvieYishnpagdBVPBRUjeIxa96S6y+gtSdxcRlwR5wJKkjkWkg01jqJSJTfhPZeUPiWfTTzZCmW0llbs0HkKHXPXAPhw3SY6VID9pPTvWdTb9BciJS545yI6ncp328gQVHQD5vXTKIxP4OjkbxY1TMTkrF6B6/gYuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+D5gU3o5wu0DXf+jmpJf+qx8X/yOh7mj1A5yJ7lhNUA=;
 b=O9LvbpHQ/Plz2GJO3Mn0trCDe6Lbuzu5iT8duvKxiqxH7tA/+DWdjX61HlAa1fGNke2LouGKhkbCpqYfGIrt0HIIpZZQUvQTyuv03Y+FASYdFqIg3EpA4cm0rWL3C4Kfo4aqPtoPfkIvBB9KmQpQf6RCzVyDS9CICLe3yx3CkH7vCpM5N+84T8/tuyaEc2iuJuMlh0xvlLBnE6jtDoA7ChNgpvfhiI2Xs/NNiVILddwNbjHjncJPeRwETWtVWSausivF4iP/CbXTn/DA2GpvTdF1x9C9G9XEFF3EgWiYYdgUyiOl25B/NmvflI1FPqieEdz7nboBVEnYoriCHMfVMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+D5gU3o5wu0DXf+jmpJf+qx8X/yOh7mj1A5yJ7lhNUA=;
 b=qOmHAPY1bMx2ABfWnGyM4mT9nhVh8Z4aOQ2foY7SzpdLMCbg5LXjnlRyJcL8rmJ/0VEmeelqxiFjKDmInAGA6i651Dyv3CuyDdHSUTMqy9dmPIGaQv+YvVwZM4ntmgHZAqJIEArn3NAA9Bbp/HwFxstE/YsOj/2R7wJLEifkf1Q=
Received: from CY8PR10MB7243.namprd10.prod.outlook.com (2603:10b6:930:7c::10)
 by DS7PR10MB4864.namprd10.prod.outlook.com (2603:10b6:5:3a2::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Mon, 21 Aug
 2023 16:25:37 +0000
Received: from CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::2a3e:cf81:52db:a66a]) by CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::2a3e:cf81:52db:a66a%4]) with mapi id 15.20.6699.022; Mon, 21 Aug 2023
 16:25:37 +0000
Message-ID: <38350699-ce4c-4298-8ebf-c9c6b5a72c2e@oracle.com>
Date:   Mon, 21 Aug 2023 11:25:35 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rdma-next] Revert "IB/isert: Fix incorrect release of
 isert connection"
To:     Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@nvidia.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        linux-rdma@vger.kernel.org, Sagi Grimberg <sagi@grimberg.me>,
        Saravanan Vajravel <saravanan.vajravel@broadcom.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        target-devel@vger.kernel.org
References: <a27982d3235005c58f6d321f3fad5eb6e1beaf9e.1692604607.git.leonro@nvidia.com>
Content-Language: en-US
From:   Mike Christie <michael.christie@oracle.com>
In-Reply-To: <a27982d3235005c58f6d321f3fad5eb6e1beaf9e.1692604607.git.leonro@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR03CA0082.namprd03.prod.outlook.com
 (2603:10b6:5:3bb::27) To CY8PR10MB7243.namprd10.prod.outlook.com
 (2603:10b6:930:7c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB7243:EE_|DS7PR10MB4864:EE_
X-MS-Office365-Filtering-Correlation-Id: 61151634-307b-42aa-48fc-08dba26340ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jjGLv9A0f30Tqvc5caCLaLwEm9wR1EqrGP5CzDPoiUQP8xKcbe/XSVqFkSIXR4Uhh34SqL/YQcTwBbLj9ZnOdNoLzW5vSwLo9wPZCsruqRrcaAtf+ElfNkSzQfoDkX1QgvXz8idj3tVbwjPtoDq5xC6cXv/glE3Lf6g6Qe5fpt3aeQUzrQ9jf1e4Xq2d2HQ5BUzsKlTGojEuXIN45wt2pKjjGl+xWUkgU6Qb1hDkaO/tIPuwen68lnMMtfH2mBHI+7vSrbyG03I3K2G8SL59xlrJgdss/MytnhwwXyII4Dq1LCzKy5naLMPcJtSeybEk0QkSB0U2tg3DQpFIPfj1U9iwQTWVHGILAgLq47aux230etphDDb7SK84UcSqw5SczNdhFq3xKfNDfkVAh8jOW92sufVLEHJ6WrXEh/aihckHSnecQDxMWxHhavJwZqy14UurFwOeCLnm2whLXSxNArLaxUSGu+UdqId47wjrCLgRkxRV874avryQEd4dXW3tOWB/R1zc3KN2C2Ksw8RpxcfCG+PIUfKsPcdoNqjF92o2hZwCMYhaRrqb3uLoU4SN40FefJCw1EA5VnMZd4LskQBOA20/o6UXX579pBMMMaZVPsVduGJH8OxTDrEwVeJf1coeLKwmJrLsqstfXZZprQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR10MB7243.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(346002)(396003)(136003)(376002)(451199024)(1800799009)(186009)(2906002)(4744005)(53546011)(38100700002)(6486002)(6506007)(83380400001)(5660300002)(26005)(86362001)(31686004)(31696002)(8676002)(2616005)(8936002)(4326008)(316002)(6512007)(66946007)(54906003)(66556008)(66476007)(110136005)(478600001)(36756003)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dklPN2J4a1g5VU1CQjR0aFl5bTllWHhURFc2UERJL3NuTkt3R0poT0thU2Zo?=
 =?utf-8?B?MWlHTzNiV083WEJ5SXA3YkszYmZGQVl3ZTA0dUFCcDZWQXRaWE5YVGVzbnJW?=
 =?utf-8?B?OU81TTBQbzY4WWZ6VFhTOE1qSldMQk43bjRzYThKd0wyV1ZTdWo3cmR1Q3Vi?=
 =?utf-8?B?aFRJcG5lK01ValZlQnVZTjdFajdrNGpzMFF2M01zb1h1MlVtSHFwdnl0K2Nj?=
 =?utf-8?B?UUxQRVpoa0QraHRiUmkzZ2Q5bC9ucVZRaHFiZU1GVUxZaEFNVWRaLytLYU1W?=
 =?utf-8?B?blhZRWJUcmQwVDArTTdlZjJrcVZGNjVVM0RPQk9xYklXVzB1Sm4rUzh2a0ND?=
 =?utf-8?B?VXJZdVlSbHlidVhubXlhL201Z3VVMVRTZkdXRUFOVkxaZ05veUZoZXpYZUhs?=
 =?utf-8?B?eG9GWVUxR2JFdUdnbWpLcGcxakRqczZXRUlJck1VUlJHaDZPNW8wUngrb2J5?=
 =?utf-8?B?UGY4bzJka29sQmpmRWZIUi9HRytGRTdvVG8wWVQ2TkpwYnFsWDA4M3BrQlhM?=
 =?utf-8?B?eDhvUlROWmRLM25yOEV3R3ZYWU9ZTkhJNUJ3UWNuenVRSmhwME4zTlFaK0lu?=
 =?utf-8?B?aU8ycmYvQzVpa05PUzZMMVBVdzJRTmYzYlBoN2NpWGhVK3VpUVlZUTJyQlFI?=
 =?utf-8?B?eHdlOTV0NGNXTzFYYVBqMjJMSVc4TW1wWEpZMFpvMUFickI1WnREOWRUU3ND?=
 =?utf-8?B?b2M0S3QzVWlhVXo0bXlPclBlNFdQLzQ3WHRtVUFjWlpTK05LVDFMWmVGQXZm?=
 =?utf-8?B?bDNwWXVxVUp2R0dadDhGbDVWKy9wN0taRm5ZRlZydXpTN3dTN1h0eklNVjJx?=
 =?utf-8?B?Y2Nnemg5MC93elNNNjhLcXBIazBmdy9yOEZ2dHlhZ0JEVStIZ0JYY3JYOE9F?=
 =?utf-8?B?L1dUTHYxQXEyTXN2bWVwMmZIWEpFSE1kK0xhZVZqdEJjUllwa0JTUGF0SWV0?=
 =?utf-8?B?VElIRjFsTGNQMk5VTzNzUyszMzJvUmwxTGF1OFdHWWw4UWxjbXo3L214VmFo?=
 =?utf-8?B?cFJrc2pPZVpadHUvbWdEbC8xc1dmbHpUOEFaa1lPTE9FWHhPbzVHbVRHSnFS?=
 =?utf-8?B?Y1pWLys0eWJ0ZElFSzdsU3dEU1J5enNEbHY0RDFxK2FGQW56V1hxQUhwWmpO?=
 =?utf-8?B?Mmc5N3FBU0VPU0xiSm1sL0pSWFdTMWZjVDNFY0NjSllnMlMxVUZtNU05UWZU?=
 =?utf-8?B?ekF2bTRuMjZYS0FpV3dXK25PM3IzY0JBYW9RK1pPc1lZUWQ3OEdOd3BlMUpn?=
 =?utf-8?B?TGlvUkhtM0F2Z2JVbDY4VTRWSFZiSVo2eVU0cHQvYVVJT0NUcElvREcxVVNQ?=
 =?utf-8?B?eTJ2WUVzWVd2eVZnaDRDK3hyWTg2ajgvdmM5NVVBZEN3TGMvTk11WU1vUzA4?=
 =?utf-8?B?MDRJMGJGeU5xLzNxYk8xUlNYRlMyQ0JNZ2pxdm8xMHdleG01Wlp1Y2ROQWoy?=
 =?utf-8?B?ZE5LemhId1d1T3FBdEJYNHZPc05JQzBCNVV2S2VJVk0rWWt2amhndDBQOENa?=
 =?utf-8?B?WnN2RUdRSnZKUHlWOXczZDh3OWl3V3p0eU9qMkttTFVXc0txZzVRM3BOZCtD?=
 =?utf-8?B?YTY2UGdXMjh1UDJUMFdaRytMd1p1ajM4WS94NFNhM0play9hUzhHVytsMk95?=
 =?utf-8?B?clR1dnFnSnRLYmk0SHVaNkpnSUZrM0RaTmpqRHVxUmo4U2dHQjZyVEY3V1VX?=
 =?utf-8?B?bXNsVkpYVUZVTGxKQ3pZczVhcGxyK2JVcGI5SnZZSGdXQ2IxczA0T1p6TzRn?=
 =?utf-8?B?SlR3TWJlaVRsYUR2TWRDejhOMDRSV1plcEdHU25kSVByMEliYmJ3aVJ3Ymk0?=
 =?utf-8?B?aDhndjFSME9kWXJYQU1PWFQyTHl4R2JKUzBnSE05aVlMRGFhL1VnWUJLdmpR?=
 =?utf-8?B?SzBqRFZtVVdsTUlrV2tlV2x6TkFWVUk5NXRZZmlOMjVHWWtsWDcveFhadWNw?=
 =?utf-8?B?ZXhRUFVlRkRCenFDam9aTkJWc1ptZ1RVOVFGWTRta2FVZHVlbnBNR2grSmxr?=
 =?utf-8?B?OFczemliVHNKbGlwTFhFL0dRTUpsWGxyTk8yVEh3cklXUFRteWltSjJzWTd4?=
 =?utf-8?B?OTZvbDhLK3M1OGE2WFVFWCsyZTYvdDR6YVVLbnZRemNXeFJ3TXlDcXpCdkRP?=
 =?utf-8?B?U0ZHN0h4bTFxZkU0VGc4QmJTdFNGb00zS0s3bEhudHQzWjNnUmxpdWVwekZT?=
 =?utf-8?B?dHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?QStiaE5KRlZDRXl5MWhtNmRyZzBnbTUxZkN5dFlIMWJPMjhyRkY1TC83Y1g2?=
 =?utf-8?B?NGJQSEM4N1dyaTJyTmpwbkx6Z2k2WGd6UmkvclZJUS9GNUdmWVV5dElLN1Q2?=
 =?utf-8?B?SWdVYVdSTWR5SkxldU1vOWtsa2IzcEZGb1JEZHh3VEhDYmszYkUrQmFCbWdo?=
 =?utf-8?B?ZnlOK1ZVbzF4bmxHZ2tseU9xVkErM0tQd2JNNHdsMlBWei9raUhnOEg0SVpr?=
 =?utf-8?B?bkgzZlMyY2NkbUFENldwRk9CVkRGVXlEaVYrNm5YYmc1UnQxSjM4Sklrc3pJ?=
 =?utf-8?B?UGJTTDBlVFFXS1cxVFR5M3hIVzVHM1krNk5LWm5FeWYzOTJra2dmZk4vNFZ5?=
 =?utf-8?B?S3VhZk9aY1BkNlBJdUNtVGRUZ0RvVUZ4bGRJeHZmV3NvdXZqd3VDdUpkb243?=
 =?utf-8?B?dlRjOFYxQkxpRitCdVovWXJ1OTE2VStxWlEvSGVOdTFhemt2aWlXN1A1OGpl?=
 =?utf-8?B?ZmxGNFM5cTlET0JwbHdwWFhMN09rUkYyTC9vOHY3MXl2dytwa1I5RFZWVFVa?=
 =?utf-8?B?Q3l2WGR0dnNtcjRJNmF2L0I2SmhDSGZYeDBqV0haMHRwZHJURm53a2VhL0x4?=
 =?utf-8?B?M0NlTkRJTm9GWWR1QlZodVFSQWxMbkhOQWJYL1RObSt2UlpTNlhoaytXbENz?=
 =?utf-8?B?Q1NEazVZUGJQcFlocCtOSHRoNEh4VDFTTG10b3IrdmZ1OVJsNS9yNGlJYnQ3?=
 =?utf-8?B?blBvTWJaT2ROQVl2b3c5R0I0SHVIS2JvOFRGbXpuYmF6QUFYUDhHNngrR1Qz?=
 =?utf-8?B?b3ViV1d0Um1WMmE1dXpJbkVQQUpDMGVGc1AwbndzcjdlL0FEWUhJbitrNVhS?=
 =?utf-8?B?UHd4YUI1aDQ3eVJtV1QrcFNTMVY1TnVGL1B3MzNRN0kyWVV2Qkh4ZWpXOXk2?=
 =?utf-8?B?SjdIbFczMkkyYUl2Z0tCMXVIamJZUW1ZZFMxcjNQWHdYWm1UQW1taUg0WmdE?=
 =?utf-8?B?ZVVieFo5ZzJIeFlkamR2WjBmMTEveURwa21zMkNGM3B0cVQyaFRkbjBPQlhU?=
 =?utf-8?B?OFAyd01iT0ZLbjFRZDdpT05nWEtKalZmM3Z5RktEcHpaZkU0LzcrUmc0Qzlr?=
 =?utf-8?B?ejNwR2NHV0FGZjlFTGttZjB2SWZwTWtrQzdzUFN2RmIxMFNwUUN5bkJSWjQx?=
 =?utf-8?B?enNOUEFnVFFrS284QzlEZDZNY3lFL21ZZi9FRGRLRG5pOWhnSXdaWUVBdE91?=
 =?utf-8?B?SzFOdmdoZVhjaE5MdSs4N1hWWkRJK3JTK1lpZ0RIbVRCVVc3cnU1SE1BQ2dM?=
 =?utf-8?Q?gG29A/Ws6/ysBlA?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61151634-307b-42aa-48fc-08dba26340ca
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB7243.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2023 16:25:37.7308
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 97BBFfpW8DiDkvT8Zq23IM+jRCLeucw+7mK4N+Mv91s/r5GfWQsMs8kAPJ/vLkXfVqI0O08/mE+Dvt7ap9gYpF6/MZ+T6Q7BfoWSTcc+xCQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4864
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-21_04,2023-08-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0
 mlxlogscore=885 adultscore=0 spamscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308210152
X-Proofpoint-ORIG-GUID: ZAK5bSn1VoAfaM-fdngQfgGtyYHZKpUp
X-Proofpoint-GUID: ZAK5bSn1VoAfaM-fdngQfgGtyYHZKpUp
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 8/21/23 2:57 AM, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com> Commit: 699826f4e30a ("IB/isert: Fix incorrect release of isert connection") is

Was the issue described in that commit just not correct? Or was it
supposed to be for some sort of race'y error path?

It looks like that analysis was wrong for the normal login/logout path where
we call:

1. isert_init_conn sets kref to 1.
2. If we are connected we set kref to 2 via isert_connected_handler -> kref_get
3. When we logout from there then isert_wait_conn -> queue_work release_work
and release_work does isert_put_conn so kref = 1.
4. Then we do isert_free_conn which does isert_put_conn to set the kref to 0
and then free the conn.

So the patch in this mail looks ok.

I checked most of the error paths, but I might have missed some. It looks ok
for them as well.

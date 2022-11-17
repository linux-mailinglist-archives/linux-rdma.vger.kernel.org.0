Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 741F762E319
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Nov 2022 18:32:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239999AbiKQRcX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 17 Nov 2022 12:32:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239931AbiKQRcN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 17 Nov 2022 12:32:13 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 820EF7A359;
        Thu, 17 Nov 2022 09:32:12 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AHG4JdW028268;
        Thu, 17 Nov 2022 17:32:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=E5bxzx6kNBUySAPtUStFMD+5GYCpivLAJse6UEv7pA4=;
 b=wDIvcjMkB5Gc+RPYAX/fyrEAAMJlyB+mRV7kQsd/4EHB1Dp4IuN1CDuZAbRGsvxVUUuh
 ccBAZkn9S2OnynvuXars9+oMS31S8qGLkxVWc6o74rdKPdPniPKnVxZ4+zbxMrHqRBxQ
 sJPHymI7BZCehY48GHRZUrW+VcSkywgfoKjO3Qvj1yNW+z5oNnGuv3uG5d+ukKM3CQ15
 MH5rbD29hXQ5a01QDuYJKxSjK+3o0AZqWiArk1fvR/5KmmK/yc4whTznbhPhfM5ZdLio
 jM7V012tVRV6T/f2IKW+aJ761+Y6ng4entbgVgR+kFCqAU33fN3vf1iM4KShwVhripUv Ag== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kv8ykssxr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Nov 2022 17:32:05 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2AHHCGrL011016;
        Thu, 17 Nov 2022 17:32:04 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2102.outbound.protection.outlook.com [104.47.70.102])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ku3ka8dk8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Nov 2022 17:32:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JtwUmRwh17FJ3UYEcu27Bo91uyBVuyat6J4efm9HpLL80zowGybI6NVRUrAGYWA0oLhN2iZrSz9eMYpme9frbabiHG4yqtmXt1ooQ8qmaBxJxoM+8otXMCUBk66cPZZbacNUeZJUydfipxQDspVXwAousfVmW8PLXhIQerhTZVjgdh8cWQr5Fo1xK9JAxrRqeEhUncSeDID8Fgm07LD+X1iQlPySvHXZnDMRXxkFO4BNT4QHXmYYZ4W+pS/n961YyTfp+aop5IDKja5VA32gYTX3AGynksgNcKiwxByIhwQ2l0JQetvS+Rk0NRXCN+jjg2uN1ggLeJH8J30t6dEfFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E5bxzx6kNBUySAPtUStFMD+5GYCpivLAJse6UEv7pA4=;
 b=QewJrJA/t1hr5ISwZXSfhooFH7DSKVbKIDiDNUsgp26yngyQl3K6Jw4G5oYK9L1FRnzcf+jkxVzHoYUQO5G56BVebBrzZ6POq+jfVflYe7XMbLJJiJgx23t+FcP4BAhVfpG7r4zdr5OH584/jDBOTMeO2AYyXmhNTZywCzJZU6RS7F9NJ6w7O7qHV87bLkJMvivotjtf9h3nBAdmNlEpIXUwtCg2HK/6fLXYIX6S21ZVJ+3r3404YceeGbyYLc3KU3n+o2/vR4VdOhMBCsceawTs4S2UQ214oBQ7CE/4DYOX194R38rltZdyLj0Ft1vNLQRBrYY3OEZsFVHgD1xDYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E5bxzx6kNBUySAPtUStFMD+5GYCpivLAJse6UEv7pA4=;
 b=PLsxy77EY8S0WTgDMu1zQ0Ks712pyUKjwG/4nHz8AWFOTpEnCU6VdPFwaIFOIa1C69x9sCGmnWZhtyC9ZyqpApLORqCmxHtzLJDzs5fKQJOqSQPWqrfy3fQAL1ZEKBGvbT1GPmR2T6/Yj4KqzKT5cdh/rpBpIQ7JWcPmcBrOj2I=
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 MN2PR10MB4176.namprd10.prod.outlook.com (2603:10b6:208:1da::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.19; Thu, 17 Nov
 2022 17:32:01 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::19f7:e081:85b4:c5df]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::19f7:e081:85b4:c5df%7]) with mapi id 15.20.5813.018; Thu, 17 Nov 2022
 17:32:01 +0000
Message-ID: <542e08f1-fb81-1805-009e-8d353ca0699c@oracle.com>
Date:   Thu, 17 Nov 2022 11:31:59 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] infiniband: use the ISCSI_LOGIN_CURRENT_STAGE macro
To:     Maurizio Lombardi <mlombard@redhat.com>, sagi@grimberg.me
Cc:     jgg@ziepe.ca, linux-rdma@vger.kernel.org,
        target-devel@vger.kernel.org
References: <20221116094535.138298-1-mlombard@redhat.com>
Content-Language: en-US
From:   Mike Christie <michael.christie@oracle.com>
In-Reply-To: <20221116094535.138298-1-mlombard@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR05CA0042.namprd05.prod.outlook.com
 (2603:10b6:610:38::19) To DM5PR10MB1466.namprd10.prod.outlook.com
 (2603:10b6:3:b::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR10MB1466:EE_|MN2PR10MB4176:EE_
X-MS-Office365-Filtering-Correlation-Id: 81b6aa0b-d7d8-4476-2af4-08dac8c1a2ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DOH+ss28vOIktNjRMZ0NbbNCSS7bOEZq6tKIZ5YB6tSJx+nh9Nbc58O76yOmy7fKOvT0OPVafx0DI+lWuen+yNrJG3ksMzU1NBnOhiYR79yu7vOLUVf6XlTWTx8424hY3FD/PLu6ls/1rneCeu5vBolM5fbNLBIi1iI/uVb2zBF6qWfG18Flb59RcW1VYcr6hJYqqDuJTv8WGz+jWnQUIcQygtcXceAOnsdIJ+OJcE/P7OenDrCyQZLlKfZF6iTgd2uRLC5pJ9SY+/Ap0+rECfLkznQhHUN3NVhG8tLowzaAyrljpCNmKjhjWe59cGpsInD/IKQcnB6NkzSgeHBwVBQC64W1WG0S50D5nZwpKh5NOVt/Fz2f8f1F4+vtT6VZ3gzYJmdXce9/Cde1/5wtXV3nm53fno2GmxkRw24zNraNdtKy8efWVMpbXcUuiOaUhfPZ0rlp8WiQadiUGTVdxhgmOi05afcUnCRDbffz+LtYy9xT6QndyYxpHV/lKvno5davoqvWUFXTyVKM0UmT7De8VgVtBVFr4XW0ggGRC0g10hk0/rp9wOgVfyvhoTLOsDvs6lKsL0OXBaBuPSWcxaQGff2++1Bv37raLlo9+jYlIscGGChSsi2KfcKxN+kYqDQ3+LFsehB/kFY7cruvMaZ2jA4hM6WKYVL5RrKhC+Qic512kC/02rKYf/3HI8frAnHHYKRepnuNIJMx3TOVxdiLqk8IXYr61cGjF1Tm0nc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR10MB1466.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(396003)(346002)(136003)(376002)(366004)(451199015)(38100700002)(31686004)(36756003)(86362001)(4326008)(316002)(8676002)(66556008)(66476007)(41300700001)(6512007)(5660300002)(66946007)(2616005)(8936002)(2906002)(6486002)(31696002)(6506007)(83380400001)(26005)(478600001)(186003)(53546011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WkFBQzA1bytiMGJOaE85R1BqYTZhemI4MFFYQ0pOTUZUcUE0SjI5RlZGWitC?=
 =?utf-8?B?UjdRNFZIaXN6OTNiOWlXcGNhUG5FSVZEZ0hsRExyaThZUERaOXNEbVhoUEl6?=
 =?utf-8?B?MEt0d0dIVlNsWEtXUWhPcmdHMzd4Qk9sbkV0WVVCZ2l0eElvQVJUOGpuaDBj?=
 =?utf-8?B?cHRlbzUrQWZtbTZtY1NkUGg0TkJ2cU0wek1Pc0xwTlA0S1dYTWtFclJSVXRz?=
 =?utf-8?B?dzFYYUZ2eHFWejVtM0dvNUN1TTR4dmdxNzRvY2tTKzlZckdRdXlkYThOUzR4?=
 =?utf-8?B?eVAyZnUySzBXVFI2T3J5bmtaVWpkTmdFZFpIL3BvU2pjZUQ5UmZJa3VVRzBv?=
 =?utf-8?B?K1hZcjVid0VZNDlBQ202Qjh4U0lFQ3I0YWlRM1FpT2FjRnFFR1ZRTmN1OU1z?=
 =?utf-8?B?UWFoYy9lUXFwTEpnNmEvWDMwaGlYQlAwKzYyYVByRjgySlN0a1VKSnhjSHJZ?=
 =?utf-8?B?d2ZhYjYzM251WmExbGNEV3BxSklxV3ZmSjhyK2lTS2pkUXZDTzUrMExyaTJw?=
 =?utf-8?B?Y3dhWlpxcmNLUVU1UFUvK1ZyWVEvbUpwVm9VN04xdmN2UStJeStDd1ZVOEFZ?=
 =?utf-8?B?eS9rMTFrR3Z0YnBpUlhCdERiYnBlSkRVODREUEVpR29ETlFGK3ByUTkxc3FI?=
 =?utf-8?B?M3FyMlE0RHVCbXB1V2xHcWM5aEVweGdKMW1LckFmVzhzU3d3QXpXbkd6TFAv?=
 =?utf-8?B?UHVjMHBocVBYWE0wbDBtV0d6UjNvU2U0N0M1ODhQUnZvSVd4ZFNXME91K21D?=
 =?utf-8?B?UUtLT1lwa1Q2bjRtVmM5OFlycWlnT0dwQnl1NWpTMFAvSU1TdHJQek43MGx6?=
 =?utf-8?B?L3g1UU9HUG81WnZ5UTl0TzRrOFU5ZGJWK1poalovUkkyMzRyOHJKM1d3S0sx?=
 =?utf-8?B?cnhxeEsvSGg4NXhMYk1tTEhKNDNBTVVCWW1zY1BNOE5PSUxFUEJlTXNxcDc2?=
 =?utf-8?B?Sk9MSm03cEF3NTRkWGl2UTQ1OWdmU2IySmVUeWdBc1BOZG5WWUthMUEvK2l0?=
 =?utf-8?B?MkRaaFVXREptRHFmWHk3SmcyT0EzVEppTmxPOW9Fb3FPZGJ0Vml2TVdyM0Ru?=
 =?utf-8?B?RkVMMFpBb1NLSHVFaFZrUXpYQkxoL3JKL2p3S2VIZXdGTmwwWFByUUp0VTUz?=
 =?utf-8?B?TVc3TEU4cjZFTTJuS3hKV0kzOUx5N0Fld3N0dzRGMWFzWHc5L2NoWDVPM013?=
 =?utf-8?B?KzZOTXk0clBtY0hZejhZbnl6R0ZreEdKL2dYYWFXd1lFZis2MGtnYjN4dFJT?=
 =?utf-8?B?RHpaei85Z0d3TnBRckpsaTI1WTMyK1ZLMzdXVEJQc2lKQmJpN2JlRFA3a0hK?=
 =?utf-8?B?WGoxMUlsTHpaV2JYci9vdVEwSXYxZDU2cDFSTGlzTG52Z1F5U0lFTnVZZHIy?=
 =?utf-8?B?TzJXV3Jja0FZUXRSbXk4V1pTSWowSUxxNkJ1bFVHSEdFbTY3MkhtR1NDN3F3?=
 =?utf-8?B?VFNQci9ScWZSZVNzbWRYM2J1ZTlFUG9Ma1lFSEtQYTltL1R5WFlYVUs3VmFI?=
 =?utf-8?B?MzhpVEJ4K3BLSjAwRDdGNUxjVHk0d3JCdXU4QmdCbHY1S2lBSU1HVm5sNXl0?=
 =?utf-8?B?dDBiWW9yNThjWEpWK3pjMmlBTzdwUjIwcVU2YXJQUFJOUjVvbGFsb1ZDNWtC?=
 =?utf-8?B?TUs0ZTFnZ3dicjRud0cxYW04bGJrZHpXaU82K20zMjR3enV5cVJNWUc3MXFm?=
 =?utf-8?B?eWdTV2xuUEdUOXR4Y1BaNUJuQ1ZQSndWWVovRWFqb1FDZSsvMDQ0VnBDTTNP?=
 =?utf-8?B?amM0d0RUdi9UZ0o4Y0dVQ09TaTZub252Y1E4WENNc2d5UlNYL09pWUZiaU1S?=
 =?utf-8?B?RVJXSzdVcjdEYmtiS05KSFFsY1l3MjdRTEtMMmx0UCtJc1htSnViN3hwTXk3?=
 =?utf-8?B?NHA4U2hhZkhGZi9CenlxZmRKQTBvaVJCRktCVk13Q2UwQlM1bFR5MEFlZW4r?=
 =?utf-8?B?dmJXck05c3Vlb3FrMlZxb0UwT1lnckUyaEZWc05lRmhWT0FaSCt1NWIrenpF?=
 =?utf-8?B?Y1lMdVhkN29TVkdXSjVPalFBemZBQVN5M0p0NzZRUnp5NEw4RU0rZVFrRitK?=
 =?utf-8?B?cVNsQWsxK1hYbWRidVRUb0NaYkVXUnRwbXFPQ0dvSGFvM2VFRjJIbjA3aEda?=
 =?utf-8?B?eXFjdUNoV0wwSnAvSmtxMTNFUndqNmw2WXExKzd2SDUwUUZENkJqbEU4bUYr?=
 =?utf-8?B?Ymc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: KgGc33OfqR+j/juKgyctM2VNC9+r2u85aQSAYI3Ht9Vtah9mrffw1pPiRrayahhRG7R62vn7yVIOx3itIEGI8SJctnm3CFKNvXayAltcMAGG6mwiGywyPTzEmFaGaECU2+Z7Rm7qVzmE0EGkTwGInbsMCCpOV8qEbYPqTjVZ3mSD+RzNCU5+2PGeu1wQVsvzBBppIRAqOLKs0XN+j0MyaEww4kyAx3uH258PBYBGcBoWwc6jF/Ji1APZz3Wmv4cISgZh0viNAggoY5zdyStkP0f/Qe9E0Tg2G+9PCE0X8fWPFk2nYmbeLC2QMfyfqx8sSgGvGiP8MAYRMZmcsaAsCj3DKWnfzn0rhAJ52MMlixWW7weuPxO2OxooWIi7QwjYN77NrmaQCtN7oZTmc4Q27AF01r4ktEjP/mTCpGv8nUE9AEw3NPQrQVeqn8ydlbmkXs7LEYveTPw/jzZvdE4IjU7viiaGaQkqol++uYjYzPfwRkp/NCozMfqB51UOPz+ABy2gCMq4MGyhMS/Rn3u2jy5GCkOdgpW/XywauEJ1cucCSyDVlFZfTmeSqSv3BY8Qw/gYtUoe3IIy9pUl76VjacIF765mEHtXaXOimCwxLGHBjtNPsQ0Wv/+52xbiWVnGumLi/qW5rmKRiyhkOQm+ndQ6/x9+XjbLBBDtgiPMJ/IoLnEn2N4R3mNYo3Lyt0Y2OqvKMScXmzA++24tphwf2I4lohpiLkth381y6RhvO5P99a/7TaMjRGxRrt0o//4K686uiycSjJSluSLObGEZHwZHJA08XlmA/egvuBUo42RkV1ryUIAessoIOz2ZvLL5t1cpqXLJHG3N57+HQzQmbl+bDr6HOJBILlx/lL6fGBtjm1scs0WcGP49O5p64x/UjgIAxs5mhg7CEsITlw8NLA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81b6aa0b-d7d8-4476-2af4-08dac8c1a2ce
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2022 17:32:01.5291
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UUHW6Bs+0PUTa1hM4KMqap5ihnj8CLd6jBOheGcgKkfXWKszzP+PzyFd0qCiqfsPSDzFM83sbDg7j14jaIfdxhhgu3JJooOUI1Buv8yJ6JE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4176
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-17_06,2022-11-17_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 adultscore=0
 phishscore=0 malwarescore=0 suspectscore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211170127
X-Proofpoint-GUID: QpncWBSyCL6E0cZWg6KBwFL1O6flTLzd
X-Proofpoint-ORIG-GUID: QpncWBSyCL6E0cZWg6KBwFL1O6flTLzd
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 11/16/22 3:45 AM, Maurizio Lombardi wrote:
> Use the proper macro to get the current_stage value.
> 
> Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
> ---
>  drivers/infiniband/ulp/isert/ib_isert.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/infiniband/ulp/isert/ib_isert.c b/drivers/infiniband/ulp/isert/ib_isert.c
> index b360a1527cd1..75404885cf98 100644
> --- a/drivers/infiniband/ulp/isert/ib_isert.c
> +++ b/drivers/infiniband/ulp/isert/ib_isert.c
> @@ -993,9 +993,8 @@ isert_rx_login_req(struct isert_conn *isert_conn)
>  		 * login request PDU.
>  		 */
>  		login->leading_connection = (!login_req->tsih) ? 1 : 0;
> -		login->current_stage =
> -			(login_req->flags & ISCSI_FLAG_LOGIN_CURRENT_STAGE_MASK)
> -			 >> 2;
> +		login->current_stage = ISCSI_LOGIN_CURRENT_STAGE(
> +				login_req->flags);
>  		login->version_min	= login_req->min_version;
>  		login->version_max	= login_req->max_version;
>  		memcpy(login->isid, login_req->isid, 6);

Reviewed-by: Mike Christie <michael.christie@oracle.com>

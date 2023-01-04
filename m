Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1073C65DC9F
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Jan 2023 20:19:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232953AbjADTS4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 4 Jan 2023 14:18:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239807AbjADTSy (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 4 Jan 2023 14:18:54 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68F13BC0
        for <linux-rdma@vger.kernel.org>; Wed,  4 Jan 2023 11:18:52 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 304FO6LL025535;
        Wed, 4 Jan 2023 19:18:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=CUg77Mq5NXlYGFZzFn2GtykpnXZwZW+s5Ks7k7WPr3o=;
 b=g4TyP9d6CV87Ig4+xiIm/HwdKyspFi6Ftr1jlHqtz8vy9GGB2izqBvh7Doi2MzUcDLhK
 Q684W3uN9f4XIrXMoXWLFcVz1+PtHw0xZLX0FG3bvBJ/IGoeFDdxq+J95rjUuxNxbvF2
 NUZtE/VhBD8R/9yUOEds7cYIWLWroBEeP9d0Ax59T8uQ8hIebV4F9RVtWYS0UVI321fj
 0LQr0pTvN++FN/VMWQUTXydS6yepkZeetSkuRNcrZEu+NUeuI/ymneVuoMXLSvjiLYw7
 y8S+06qiz5M2jPTVNPPr0SM/+w6xEUykfGQNJMMpwBEtjD9pNGdZVjgZ2bAKmUcjKk7A Gw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mtcpt7aby-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Jan 2023 19:18:48 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 304HsPlp018201;
        Wed, 4 Jan 2023 19:18:48 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3mwe90uggd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Jan 2023 19:18:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BvCvxlui/HaYzJOf4WbPemHWz4NFGYNbfo+qQaIk0gKvKsi1oNnaPGB0DjT1mJVLXOHueK/0Uxrv9HYfYdj2NrfpZnvcngFpZvLBrzLpMEjpO2Sx9FXuglWcEf7qGzpFf/J78m65I+/G6qpH+vtZ0RcAxe9SJGuzvV6KASFuJKmE6u3KokvdLwEEwD+wkYBjgSpSuzM0rHcvZVwGA0JcUcPDqZbJy7o6oQOI4Gzge8v6TvkHwy41ZirRspkSd5cVnxNDmZjV7GHfOZ/BRRtwHCtsX7r2EQqm1OUl7lCJSJ9n/y0aJtNlvtB0CQ8kM0ynODaow5vchjz40CDyd30e5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CUg77Mq5NXlYGFZzFn2GtykpnXZwZW+s5Ks7k7WPr3o=;
 b=We9H/GEKeRN1KecRDGtQvFi53P1ZRg1HA8CMIe0U9i/IS7rk/b9CsW4cl3bmCd+SnzEeiG3Iaocov1KQBXE2MY2Lb2Vn5dBdvVpGzzXe1g3zQPswV7ebL3y02kJtN2Bfgf3lw0XJSJigiuHAK2gkRVrMNU6DBJxttuoTMsPwRuE8XFMfuoNtCjhPVZARYax+XWhIiwOyUCC6dpqSYogMVVMCW8+xBYV6z/M6/7psIxbAY1FvJLMRWstIrumAwUMJNqbculfWQNZ2tRbop0qVQJfCfZdkpP80oovU+JDY7UTVkCizBWc38SEd/ovr6V5QSdDHoMfataXpUAnZYV0qHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CUg77Mq5NXlYGFZzFn2GtykpnXZwZW+s5Ks7k7WPr3o=;
 b=fNu5r9i8o8lyrH1AHr65Axkae7XTxcfDWWH1ly368GgSLobfTfKXCoql81DsEmuEnZFOhYoIZRu9RNnW3WGpVdPOfr84IyJ2f7rfNnuDbFn91keXc3d+RrxGF5Jc/287Hf308B2CFw1Plo514JEYQu/1rDwAYpUgVdbFAahuHqA=
Received: from CO6PR10MB5634.namprd10.prod.outlook.com (2603:10b6:303:149::17)
 by CY8PR10MB6466.namprd10.prod.outlook.com (2603:10b6:930:62::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Wed, 4 Jan
 2023 19:18:45 +0000
Received: from CO6PR10MB5634.namprd10.prod.outlook.com
 ([fe80::af6d:aa0c:3086:ad13]) by CO6PR10MB5634.namprd10.prod.outlook.com
 ([fe80::af6d:aa0c:3086:ad13%9]) with mapi id 15.20.5944.019; Wed, 4 Jan 2023
 19:18:45 +0000
Message-ID: <3c924ffa-5f6c-4a88-85f3-7995e399fe86@oracle.com>
Date:   Wed, 4 Jan 2023 14:18:42 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: buildlib/pandoc-prebuilt
Content-Language: en-US
To:     Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-rdma@vger.kernel.org
References: <4c29b8d8-c4c8-a7ae-e1f9-ddce3b55d961@oracle.com>
 <Y7TF8EK/PXiwKRwU@ziepe.ca> <612e156e-d8c7-ee17-430d-9d6d85427a3f@oracle.com>
 <Y7W3dASpXM7/br4i@ziepe.ca> <Y7XIrX1E78KyfWud@unreal>
From:   Mark Haywood <mark.haywood@oracle.com>
In-Reply-To: <Y7XIrX1E78KyfWud@unreal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DM6PR08CA0016.namprd08.prod.outlook.com
 (2603:10b6:5:80::29) To CO6PR10MB5634.namprd10.prod.outlook.com
 (2603:10b6:303:149::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5634:EE_|CY8PR10MB6466:EE_
X-MS-Office365-Filtering-Correlation-Id: 311ab9ff-0832-4cb3-39cd-08daee887ff3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p2Eit0iAr6EvlnfIP1voZEi42u3qVI3K5olmOyJIUBLA5Vi/FvMiJPzmuEUJb5lyn/RtKRe6SUiXSyafkCiY6Vj9dmpsyhMezJ3dsJInxnR7cDMgS6fDfXZkSr//fuRKGN4wzozq+AwEbbdPkGNoPV3dBsibcFXwZ4xTT/jqzO556OJJcCzBnggmNEJqQcLAPi7fB0UMEeuAyk1LDh5YitRkYhzXVQOnrG9k+0pWRVq7em8EyG2IBFQEBIJ+5HZcHUuyyiwIP/y78VKSTkXfEVn9Xv9UX8cLqZ8a41dT3wosh1Q+dSGN+F88p79hirGhyHe1UDL3zhRg8TiSF5i/Z0tp0RuLsC8VXx2oCDABdZB2WUdHUE2mUtJbLyIc5Xub7JPh0dhF8oecWMbnAbhhBkZriMpKj/bApcUdx8/964GbIPo+5VeECjBlIgE1HRXRhxL0hHzlqet2jV8UDaUtBImPVpHF/luNL6ZcwoYSLgLT4HUStnZPK365XKaJrlsPGMwA1rTl6mMF4JhF2grlvAFL2qjvZ5wVzJ5auHE6MUagKkVUNvGFJyucWCUQ/QFjdlVfz6SkkMvP8gWfaAsSjTWjnnkg2jb5M9brrc1jA7uinPfPs6oiVI2KNNNEl2R/Ud7Lm8QfHc2BNfVR7Vn9DwVfh24mjnnitk3KN3v9O/ndpiys/gOUm4O7GG2aony16yxA2iBBSkbSL0PfCbzeq+SXBaYEq/QJG28hWNca8sbjPI5p6AmuF4nrPkXA38xHFT/24eaTXIaAcXHex9PhYPVySay9MDAjcMjc8VMJNNDBEeTmGy/SEd2GIYZjjnf7
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5634.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(346002)(376002)(366004)(136003)(39860400002)(451199015)(6512007)(316002)(6666004)(110136005)(186003)(2616005)(8676002)(66476007)(66556008)(66946007)(4326008)(6486002)(478600001)(31686004)(6506007)(966005)(53546011)(8936002)(5660300002)(83380400001)(3480700007)(44832011)(2906002)(41300700001)(36756003)(31696002)(38100700002)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eFZMREtZUmM3SGcwUyt5V1lQdkZqTk5tMGtaeXRmb2NSaVBvU0NvRUZNZDd4?=
 =?utf-8?B?T1lQTWt2Qk9HWVlKN1FWWFhEYi9kOFdkNURYYlB2dXc2cVFHZkZmdjErbmR2?=
 =?utf-8?B?WjNxUXNBdlJmb2ZNaGdNdEZvdFQrNEtkL0pueDNlWWhuNjU4aHVvUzhwODlZ?=
 =?utf-8?B?WU1GSnhzMFZDNWtmZWJGdTNHR2ZYZ1MzWU9ya0toTkxIYXBzbkhIdEJCZkpB?=
 =?utf-8?B?YXJLVit4TkFGbjdickU1RUZ1bnlRbmpZYWNpbGpTSVlISUhyVzhnRjRLVGgx?=
 =?utf-8?B?OUNtTmtVbkpVU0RFK0pzZStqSm4xVG9OTWM5bSsrcE1ybHByanUyd29jRjJt?=
 =?utf-8?B?ZkhXbVV1Y3h6U3IxSm44WFI4YnR4azF2ZUt2TWJJZ2l3cUtvend1WHVmM3Nj?=
 =?utf-8?B?SlcvNGsxT0FsSGZLRmR4Y1RRV2RrL1BFRGpQVDNnd1paS05pNVk5a3MrNU1y?=
 =?utf-8?B?YUZHdDk3ZGpiME5DT25zdmpFVTJDQmpWdGlWdURGYy9VM2JMb29HcDZpUGRx?=
 =?utf-8?B?emNOS2NiR21YdWRoeU1uMHVncVNFbFJnTWs4cHFYaDFNNk9lSC9TUFFkbnZs?=
 =?utf-8?B?VUEyZ3p3OUcvekFGT21Wc2RCekhJcjRNT1puNkdzR1VNL2hCcnNLQ0pHQkxr?=
 =?utf-8?B?UWt0VzUzMkk4M3hkMTRIRkNCbFhhVU5xQVJQWUhGbm1LZE9QWFNaZGRhSStY?=
 =?utf-8?B?R2twWU0vOW9RZ3Y5SzdZWGI1SHVPa05FOUVJVnNidC8vRGtkK1NLNlNjb2Nl?=
 =?utf-8?B?OEtBTW1BZkFua3FJbFViZ2pXUnQ2Yy9yQ0FjeURlWW5qVENzVm5OMURXYzBV?=
 =?utf-8?B?ckxma0pSYjJiRjdDbEgvYjA0R25zNEYwQnVzU3dxZU1yU0Z5NEdhVjVFcE13?=
 =?utf-8?B?ZERWaUpKTEkzeTl4YmhTVDYzcUMxdGd2aUdZQkYvdlZuNXd2d0VOOHBXbENy?=
 =?utf-8?B?dktKcTFrdnd4d2RBNXkxcllLbVNjREorZ3VBSjhzZmpUc01qd0locXpQdXJv?=
 =?utf-8?B?Vm1qQnN0RGZlM0Q5NDZMazVxNy84S3I2K1ZEcyt4ZjBLRGFTdXJJL1NTRmh3?=
 =?utf-8?B?bzUyNmZCb3Y3L1N1a2loVGRTVld0bUdYT0Q0cXE2TkdQOER0eHRMWk1WNUlR?=
 =?utf-8?B?RGxUU1FxUFNJeVFKQmhSaHZsM1dpdWZ3MWloUGozYzlHYmxDZ2VvVnVWNkVB?=
 =?utf-8?B?clBEelFWbFc1aE45QnFmc0JmbEduS0FHWU1tRzRVbWtOT3YwdzUyUFF0dU9n?=
 =?utf-8?B?bGlJTDY3R1QrcDZMQ2FkdVJtMWp2QWZrYTU0RTJRc0s1RVZ0RUpBWnN2Q1Vr?=
 =?utf-8?B?cHk1TllsR0htRHJaVjBYR0RpRHhsNk1PNG56RXZyZ3BYbG02ZG5lRmsySllT?=
 =?utf-8?B?aHJWWmFXcnVGK0p4b3lFNHpuTWpyMEhLMWNOSERVN2ZDSE5velhwQW93dG5h?=
 =?utf-8?B?VjUzR1pQaWY1SjBoR1ZwZ1lTTG5Tb2pNS1VuWXhrczkzaVIrZmlocWVNajF6?=
 =?utf-8?B?ME9zWDdnWFI2Sk8wSjJBOWVDL2ZEaFN2NjdjTU1QMU9lcnVYRk9qblo1TzA5?=
 =?utf-8?B?SlRtNjlpdVpwYjVscWFUclZHT2NKTkdneWl0bk5TREtyNkkwZlBSeEZYeUlZ?=
 =?utf-8?B?M1ZRNjErK1JUTVNzbUg4azFqaWh2UjNIVkJ1ZTNVblhXaks2S1ErR0NrNG40?=
 =?utf-8?B?aHFHaW1RTVRQU0tVSytOYSsvZGUyaXo5Mm82cGtjUE5sY2NzZnZBbC9DdnF3?=
 =?utf-8?B?bXNLUEQwL3ZjTjJkdFFxUUh4c25udGo5VXlxR3hWOEFhKzhBWTBIVE5DMTI3?=
 =?utf-8?B?L2RVeThsYTZ0T3dNTVp6Snl5N29oTVBCdzF4TDVPalFDWCtXMEM3WElhNDM4?=
 =?utf-8?B?UnFpT2NzMTdCQ3NKV2svOWJ6R1JjcXBQWEV4Y2o3eXgrVG1pRllaZGNBU01v?=
 =?utf-8?B?bE1COXp2QTVkWkpnNExjKzVGQUgzYURacUJlM3d3aU1GV05VMnRja3VVUVJK?=
 =?utf-8?B?TENIZzR6YkpUTHdUTk1LU1c0Yit0Y1RpV3ErcjVCMkZjWFNpWHFjQ1I2QlNN?=
 =?utf-8?B?TTR3WG4rRGtXZDVlbnVmeU9ucHNqVkV0ekJVU2VqMWFQQ0hEenZ4MFlHdXdz?=
 =?utf-8?B?S2hWMExRSW5OREpKdXEwVDdFa2h6RDR5L09tdVZJSnhNZ2RYa1NDOUxXMmxh?=
 =?utf-8?Q?VyfeRrNnh4ix+nwgicD1Nls=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 6MahAT0P5vfd5QiPYsVPY1WCIthGNdI3/XhgMmIMqqdZ2/HUVrqYmBhGbbOFQYC7GqszEUweEEQCntqSyFTmG2Soew8NDS2pdi9OrVvPzsJWuY8LhSWC5ODrwxerRdl/Ud0VREtoqB0GeVp68KnGenuf0HAzzfPYlSAW3oN4Mo26zMfGdyPcns0k7q3T4UpfrKKHlt5Qm2iqVkKX/FxGf84nWQN96elN9uY3m25tKdZxhYC9xhmvrBc+LDM7HHptcUNnOfn0mIeJk08JNKGoloWMm5nV5azGbh1KeZs+VazYb9wcXGxpVPvn2xlFjrJjjKen1rkKQ2J2NOQnMJbzU68IwblaJgOW4z52cfzN3lolexTByb+MJjlaxRtQ3sLAgBi0iIYKOf/v8MkGFEZ31I9hTROKPQbQcf+LCCIwHyHJOaR+Ljzd1C5vJ43fntPfKhfP9vHwGhJVQL2WgrbmKspTm1kfVx/Dcppp0NC5z67rPBlEqP5E5kgZ/ytVlwF0drCeEbExOAcbgRvePzhNcANGLUH9XNyyjnwuC7/Xg9UBpbi/hD5VOq+JPbwOPD+yjRoTxLVIpJdGhORI9ZxY3r0U/snV3f3od47XDVd/11hs/i0iFpG5INJS+2IfaK1R53sWhQgwgbaegem3ACNM+8I4Ocga0S/Hi22Q4epAa+nylRdGH/QyOXaAppEWW8u13FDkYm38soRx59I+UJWAxO5wvOOJG81FmFPMvzW9k/+Sh0yBiXepOg5t5Jj3N9jfhiovcFApX26USu1t3j9v41uCicAfU1GaayhKgQ/wMD0u5NBuRgrOUjjH8xVDK7zv
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 311ab9ff-0832-4cb3-39cd-08daee887ff3
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5634.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2023 19:18:45.7674
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lHMH9j61HkY5TUXBH9ZPWFpu4aq21zJxUq2IcYXlFmtp1NffIEOJktzomaAx8wAwryPQhKo4XxYdqnW6gxwHoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6466
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-04_07,2023-01-04_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 adultscore=0 phishscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301040153
X-Proofpoint-ORIG-GUID: aLsSL5NtR60TCc8eZQA5GiuM0MY41EPl
X-Proofpoint-GUID: aLsSL5NtR60TCc8eZQA5GiuM0MY41EPl
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 1/4/23 1:42 PM, Leon Romanovsky wrote:
> On Wed, Jan 04, 2023 at 01:29:24PM -0400, Jason Gunthorpe wrote:
>> On Wed, Jan 04, 2023 at 11:05:53AM -0500, Mark Haywood wrote:
>>>
>>> On 1/3/23 7:18 PM, Jason Gunthorpe wrote:
>>>> On Tue, Jan 03, 2023 at 06:04:21PM -0500, Mark Haywood wrote:
>>>>> I just extracted https://github.com/linux-rdma/rdma-core/releases/download/v44.0/rdma-core-44.0.tar.gz
>>>>> and noticed that buildlib/pandoc-prebuilt does not exist in v44.0. Is that
>>>>> intentional?
>>>> ?
>>>>
>>>> It looks OK:
>>>>
>>>> $ wget https://github.com/linux-rdma/rdma-core/releases/download/v44.0/rdma-core-44.0.tar.gz
>>>> $ tar -tzf rdma-core-44.0.tar.gz  | grep -i /pandoc-prebuilt/
>>>> rdma-core-44.0/buildlib/pandoc-prebuilt/
>>>> rdma-core-44.0/buildlib/pandoc-prebuilt/caaca7667f40fff2095c23c0f40c925f1ff3edea
>>>> rdma-core-44.0/buildlib/pandoc-prebuilt/e2cfc53feeefa2927ad8741ae5964165b27d6aee
>>>> rdma-core-44.0/buildlib/pandoc-prebuilt/971674ea9c99ebc02210ea2412f59a09a2432784
>>>> rdma-core-44.0/buildlib/pandoc-prebuilt/241312b7f23c00b7c2e6311643a22e00e6eedaac
>>>> [..]
>>> I can't explain it. The one I pulled yesterday doesn't have them:
>>>
>>> $ tar -tzf rdma-core-44.0.tar.gz.orig  | grep -i /pandoc-prebuilt
>>> rdma-core-44.0/buildlib/pandoc-prebuilt.py
>>>
>>> The one today does:
>>>
>>> $ tar -tzf rdma-core-44.0.tar.gz  | grep -i /pandoc-prebuilt | less
>>> rdma-core-44.0/buildlib/pandoc-prebuilt.py
>>> rdma-core-44.0/buildlib/pandoc-prebuilt/
>>> rdma-core-44.0/buildlib/pandoc-prebuilt/caaca7667f40fff2095c23c0f40c925f1ff3edea
>>> rdma-core-44.0/buildlib/pandoc-prebuilt/e2cfc53feeefa2927ad8741ae5964165b27d6aee
>>> [..]
>>>
>>> I am sure it was user error on may part, though I don't see how. Regardless,
>>> it's fine now, thanks.
>> There is a second link:
>>
>> https://github.com/linux-rdma/rdma-core/archive/refs/tags/v44.0.tar.gz
>>
>> That does not include the pandoc, perhaps you downloaded it by
>> mistake?
>>
>> I don't think the releae tar file changed at least, it is generated by
>> a script
> Right, I didn't change and/or force push anything after initial release.


No problem. As I said, I'm sure it was user error on may part. I think 
Jason is probably right and I just downloaded from the v44.0.tar.gz link.

I just noticed that clicking on the v44.0 tar.gz link from 
https://github.com/linux-rdma/rdma-core/tags downloads 
rdma-core-44.0.tar.gz on my system and it looks like it is different 
than 
https://github.com/linux-rdma/rdma-core/releases/download/v44.0/rdma-core-44.0.tar.gz. 
And, of course, it does not include the prebuilt pandoc files.

Thanks.
Mark


> Thanks
>
>> Jason


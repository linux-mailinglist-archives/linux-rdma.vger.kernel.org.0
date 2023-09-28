Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC9767B25A1
	for <lists+linux-rdma@lfdr.de>; Thu, 28 Sep 2023 21:02:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231387AbjI1TCk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 28 Sep 2023 15:02:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbjI1TCj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 28 Sep 2023 15:02:39 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 166D5195
        for <linux-rdma@vger.kernel.org>; Thu, 28 Sep 2023 12:02:37 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38SIEKjM027190;
        Thu, 28 Sep 2023 19:02:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=tGWM20b5YUxTuBSnliqRNBcNhKoRuXOrcCPSNfU5oSE=;
 b=jEN6+ZxUpCG6NYZYHEaq76Ly/dCOO1pZ4kgNZRnq0YjriyUtRJmz1NK0cHspSP/vcTd7
 5Bxgg5xzAulBKNp6JKhXnBNEg2B7RV4JsooUXWASs85Dt7/oE6rflQ5CYdHRnuIWUoxN
 ajlXv3UYVspFVvQIfTklnGxJ1b94DV9PJiF924RMmIKQn/xXz6VIpeUlAygrBGmSCFCN
 lyZR0YyVI/ehaitBvBk5jDRgynls0Kuk9ruoOefIhiMSqDUsFHo1Z5ktReJyM17+MFI0
 6vfnTRHI9dJIw+6PqEKt1OGDZtAhPWROjU5QdDco9yWYnbiPPJ53PO1uov+PpFP1afsC JQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t9r2dnfqh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Sep 2023 19:02:34 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38SIeg3X040667;
        Thu, 28 Sep 2023 19:02:34 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2043.outbound.protection.outlook.com [104.47.73.43])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3t9pfgbmx4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Sep 2023 19:02:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eoM/4iUuZFYuEeyiAqq/qDJMcQs0xpTw8LcrBDegGDyzB4zr8PlyGG2LN/Cv3zar2fBWyVcg7autma2ZTaaGS1NkuvpNk6wDfnQ3cbayMYI27hVz9MEXgUpe5qd7d3SBkV4mvPcuBkMyFJsTtgkSDU2CB5X8WOt7YB2s7oudEsMOC5BYtVp48tvUzW4V4MH0jlU7f4pRIeJxiFHPWdjmWq4I7LD58Gw3x5BKHalK2/7szkSQmfIJ+HmwN5rxB8Dssg9A/slLCPJi6bE4uGqeLz/sc2Z5+uugG34rb9uJP2YX6BcEqjtVsI6ZDt9KZ5D6mh7F8+hZp6WvEZkHxx2lew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tGWM20b5YUxTuBSnliqRNBcNhKoRuXOrcCPSNfU5oSE=;
 b=ae9kniUCueoFVb9lYxo3Ta4GFb+RuVMYpMjawf1alKflCfHN410t6OE7fOSrz22P2pQJsoDGliBTmoNaocF/FNU02MPQlN7G/S8H23NzzVT0wKdMLuxwHFAfjiwTzuYu1JQUj9SXN86/ggLUH72uGp4RBwRjCkqr0Ut+Q+waTWtu2bPBzrABTSjp1rbEAQDYpEP8KwJArRZjG/73uO0sI2cOO6XjTzND/vaz4PSHflYZQWfHO7Pe7nsXAHwUGjUybLA7EwBQ3pVWsgWfyzTXIkJ8LxWwaZzudam3qLM7aScMynPEouNC/vdNBn4WJ43W8i/Euo1sLefDaKVQtVQWzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tGWM20b5YUxTuBSnliqRNBcNhKoRuXOrcCPSNfU5oSE=;
 b=gfUu3Ua47WEQ8QG//WFBFBfz01kA62wlSvezwWNOM1ePvX3y8M77iRV060DQeVZATF6l289bzXPWNLor1gV3xSZpk+AXfZztqbYiH2lbzRwYIFWc37mPA3zlWaXGlmw73Qv+EtaOC3xkHsoj0qbC0AmF0xg4IAYQt9hyzXbZqkg=
Received: from CO6PR10MB5634.namprd10.prod.outlook.com (2603:10b6:303:149::17)
 by CH0PR10MB7500.namprd10.prod.outlook.com (2603:10b6:610:192::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.21; Thu, 28 Sep
 2023 19:02:31 +0000
Received: from CO6PR10MB5634.namprd10.prod.outlook.com
 ([fe80::4e91:7c56:779:4dd]) by CO6PR10MB5634.namprd10.prod.outlook.com
 ([fe80::4e91:7c56:779:4dd%3]) with mapi id 15.20.6813.027; Thu, 28 Sep 2023
 19:02:29 +0000
Message-ID: <c3d2c41b-3991-6ce8-80eb-fe5560200e55@oracle.com>
Date:   Thu, 28 Sep 2023 15:02:26 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [ANNOUNCE] rdma-core: new stable releases
Content-Language: en-US
To:     Nicolas Morey <nmorey@suse.com>, linux-rdma@vger.kernel.org
References: <4410ebe0-c4cb-98ce-e493-0c6cd9a57b74@suse.com>
 <7659c824-ad3e-eb6c-1928-fd438fa68e70@oracle.com>
 <cf5c0c73-46dc-4091-a578-262d7629f85f@suse.com>
From:   Mark Haywood <mark.haywood@oracle.com>
In-Reply-To: <cf5c0c73-46dc-4091-a578-262d7629f85f@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN0PR04CA0076.namprd04.prod.outlook.com
 (2603:10b6:408:ea::21) To CO6PR10MB5634.namprd10.prod.outlook.com
 (2603:10b6:303:149::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5634:EE_|CH0PR10MB7500:EE_
X-MS-Office365-Filtering-Correlation-Id: 90dcbc16-2794-4b47-f8c2-08dbc0557659
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A2iGugAlZdBf69pElw8chV/FBMTzNuqw+HgmIA4mGFaDCzLqVRlFJLlB7k90qStMOC1AZtqxYjQqWT/3gWG+h8MO/RufIc2ZBD4jqfiLPavLNPP/j6sFEc/9u+O1v3555x+S8+cq9LUl6SJp1xRXO3uVCKNr3LF2rQ6u4Xtdrew0Uh+T/b9Fm2NbxZrCXXn5NdtyFS9LzwUGYzmzi77CH3sVo/JaDmbDOhc/LF+vpoOtL91eO8BmSKjjbXKfLZGf6Nz9VF5XYAKAvjl58xJV1OSteWhd+w5tmvVJ8c8g8rz5N3qQcPIrIQ+qadnH4gXHogNdG/tBI7w9EZltOYIaX0GMkhpeDHUdPYLWF9DtLm1cUWBxxHpNRJ3NIq/qwA/CYlNIgnPLIP0Gc6FjIG5IAZ+Y45v6NXO9eqnHep8epTdivfPRSgr8B91EEgYnRMbyD8VlmAIXiXTC2ff81XRIjmtk26G1pRk1MuV7c+Zvi9cWtTfqTClCwSSYcmHjqWSZjDKUyQedWhjNsugdLdZsYYqjzA/a4g7Elyd7RyipKmFpirDlMZGOCC2NTYorDyfobnQSHtz2dqEA5vLmDPHmOZ5UfBlU2BXmiB2l9sBZBPzBby0L5o7YZ7UPtOyNdK63sY7bOqt5UwzCEH2ysITcFQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5634.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(376002)(136003)(396003)(346002)(230922051799003)(1800799009)(451199024)(64100799003)(186009)(38100700002)(66556008)(66476007)(966005)(66946007)(31686004)(316002)(6512007)(41300700001)(6506007)(6666004)(53546011)(2906002)(2616005)(26005)(478600001)(8676002)(5660300002)(86362001)(8936002)(44832011)(6486002)(4744005)(83380400001)(36756003)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?emNTQ1VBS08vTGpXMElxVUN0Y2V5OUVkOWxucFdLVkhPaUFhcmtFOTlRK2lB?=
 =?utf-8?B?OG5tZnhuWWJ0SDlpbFNBNFlyMXd4TUxrZnZPM3ZKMHJLKzlsNHZ2NEt1T0hp?=
 =?utf-8?B?R0ZwbmMwVWhaMXUrVEErOUJkcDhJR3k3M1R2cm9YR0ZPM2R2SVFweU9rUzht?=
 =?utf-8?B?eXpoSnVCZWJTTkYvcW5JWWZnZjQybXV4RmpMT3ppM3d0MDVvYnhlVzNTdEo1?=
 =?utf-8?B?d0ZFZVZuTWxPUjIxRU4wVFFIZnRER1c4ZVFMY0RqMm80OHR0MjlVQitvVUIr?=
 =?utf-8?B?WnVxTGgydlhZM1p3RzNKZUloNEtvTE9wZkFFc2dwNnRGRGNtUSt1MFh0QnF1?=
 =?utf-8?B?VWR5YTAzeXdXQlFVc3FmazVCdVkvaTVlY0NKWEpCbU5zQ0pIWTZ5R2xaNnZk?=
 =?utf-8?B?c21DSHQxV29aR3F6b3lJZjdUVFpNVTVmd3pORUZDR0trZ1JhVUhsYlZ4Z1Yv?=
 =?utf-8?B?UWFmdVZnM3FIUTVON0QzNjF0RjZPRlhMMkIzb3MwZFcrSHc5cXFOanMxWGdC?=
 =?utf-8?B?UGt3SjdJelg0emZPSUxGdjlBWUFWWisrK0dRdkhqbytRdlc3MWc4a0ltSDNT?=
 =?utf-8?B?VEVYaC9mb3VMUHpyT3RkdnNRbDNCTWY4ZWVFRm04OVJibHJaOFB1UEdOcXkr?=
 =?utf-8?B?QVduK3RYa3o3YmtPbHFqRWVvbzJydmk1WEdTS3hQOFRNc1h2V0d3NnRvcHU3?=
 =?utf-8?B?NVppeDVHdXduMFRvcnpEYVRqdjRpc040YlBPalk1VThaZk9RcFpzYnYybWZa?=
 =?utf-8?B?bVhOdUNuTURXbVZ0TEFjSFU1cHVBcXdFbHV1VmdSQ1RFc3orZFN3eExrdGFC?=
 =?utf-8?B?S1l0a3JJNTdNVWhYazNmVHVOM3JLaVIwVTIya0psZFRiazhtSDV1M0lWdGtB?=
 =?utf-8?B?RUlkVm9MdEh6cHBoZEFPQXp4bFYveEhJa3ZDNWs3am0yY1VIVEl5SCthTlhw?=
 =?utf-8?B?OHRDRTIyem5qNWpBVUxSNnlyZ3I3bW14ZUxEK3lFalRBYUw3ZjdMRFQ1OVJL?=
 =?utf-8?B?MnBxUFlJK05JeXBCSVZPME1hTTRRNU5GcjlsUFdXWjI1eTNpVmlaQTBOUm5n?=
 =?utf-8?B?NE56S0lQOFdtQnB4RGtCdjZOTEpJL0pLQlBYWmR2Qm1YdVlnRFhaN0EvTFB1?=
 =?utf-8?B?NHJmSldvSEdGcEhvbWRpNjJuSTdlQTd5WkVZYVVwRmhMaVRrTkkxTm44YU9l?=
 =?utf-8?B?VTUySnNmU0lVZHl3MEN2czhnVUgzd1RqcDc2aCtJZnJzMUJKd2V5b25wbnJC?=
 =?utf-8?B?a2dlTDJudWRhSmtwREc1NGNma1ZBL0d6MkV3ek9BSFZvWlNadFk1KzU4ZHNB?=
 =?utf-8?B?NVE3VVRGVkxhVlhCclVZSXhibTBoWUNkUVRDa0xwZzd5eDNua0pWdEVOMUI0?=
 =?utf-8?B?TFF3U1F5dUNlR0pUVytPQU5xb2NmTzJuRUsyMVB3Ti9PcndVR1F3K0pFdDhw?=
 =?utf-8?B?bS84YXZWeDNFblBRU3Z5V1lwVXl5YVRlSzBxMlJjYmRYNTlaSzROZ2hMLzcz?=
 =?utf-8?B?SkpUVkQyS3k2bUtEMkZQVUU2Mmdxb21aOFYyTzNWY0NNZTNLNFhtWVVJYm9I?=
 =?utf-8?B?WWZjOGJZOGxiUlJxOTVlaTJBbWRnM2xBL1RsVFdjZW5RbnZoTll3NnB5cmlG?=
 =?utf-8?B?Z0xvYnR0NTZoUERWWkZJUmdtL2lnRjZkaUdNeTcrdWl4QVoyblRDL3hXeUQv?=
 =?utf-8?B?WlVFbUJpaHBkMk5vWHNna1dkZGdSR0Y2Y2J6K3dPcXFrd1R3VFY4cC96a0Qv?=
 =?utf-8?B?OWZ4YzJIanZwN2NSWE9Yc3BaUmNVSi9qdXRLQmpUcHFKN202WXFwamM2cnZN?=
 =?utf-8?B?NjRoell6VWhLK1RYamhFUDRkRTZLQ2ZKaFdXKzFOcEt3eEkyR2dKSGJTVzlJ?=
 =?utf-8?B?WDFUc1dINWhDTFA2VUczcVpMb2h5YmVxSU51bncwaXplRTluQ0RFQ0owRXRC?=
 =?utf-8?B?M1p0L0NnZW9pdFlVL2NiR1U0cUdhT1R4ZnNFZ1ZrdkF5d1RpOTcxN3ViNEdo?=
 =?utf-8?B?b0V1a1VhbVkxekt3VDJ3VmxYaTZVcEQ4VHE2ckVHMW1ha3lVU0dFT05pbzBS?=
 =?utf-8?B?SUJMUmpkcGNSS3BiZGFpcWt5LzE5R3ZGamFlK0Zyb040SEFJOFpUbkt4YTRY?=
 =?utf-8?B?TEhDREpKUzlrcVE4R3Z0MHVEWWI1bkFzN1lRTVViUW1FLzlEOWFiRm1iek5J?=
 =?utf-8?B?QlE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 1vcZihOofl9fMIrgyFqZvMR5GO1v64g/4nsyplfJcksyYPCVj+ryvZApnOJAkMi8l7I56c+6idUZzxvLOwmrQIy4SrZIdFahAHZ7N3B0FmtXa3I05F6vD8ZPYaPyFf558yH4gJhHkny+kJNQA9U5D+S0Xh4H9pYaAXj0EIf3EH7fVNhmiLKA48z/xFvWKatRmpwg6y0/AiW87DZxLm3lToM2s5qD7XelHZnBu4T8OjDi0WtEgXHz/flSxGaOgoGp+JXNWEduOfWVXsGPRQuvChw5/aFmn8BT1tlOjwINfXyGMBitCYhe1Q0HpS3zO/HIdI5MYR9YxlGJvSa6yNiVY5L1l1qOPA3pkVITy8uhXvGer443D/MrUOsNm8u9bd8ozBL6ySNVYS/TdWLfpRFifDf0fGRmSmK7pv6+7f5HJO6Y6EZBe5+lQBz2aIrZgz2zF3ilhmMnxpHJrGgbKyog/YPitSn6nEhHBgUtZA7O36YeZE2UViD3v/7ysk5cqDnOQmBgzAzp3ZpmVViMLoxF13GbKZUMGd0H9IH2b5a2LzDjT8YTf+kLZWvl3J0WrqbKRc2uD+eKvOTyy2nE5zojgUzqhvEedR2oS8yg8arF1cjI7n2+DBj4mIeG3fyTzVlryDSjJa6rIQwfasJcaku9Fk/ZhS2C1KaFwTKMoeWEHWjRi8su70/yK6cAp/RW0+U+ASCKZeFqmaKQUao3+IDcV9vLLhQWyUhXuAO7g1L7qlU2z9ok2wJbX6X1CNeMpyviQeMUnXA1tNDAbm9AMkvNYqmfpQWPgfZdffnqo+F5yV8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90dcbc16-2794-4b47-f8c2-08dbc0557659
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5634.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2023 19:02:29.5201
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zmeh/i73UVvKkmOZeq8ZoHvrD7pnn9Bpfl95sTJmROi7fakmao8wX8M7d1eClxdKTTS86kdF6DPNgotJqQkc7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB7500
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-28_18,2023-09-28_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 adultscore=0 phishscore=0 mlxscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309280163
X-Proofpoint-GUID: DTSkaca_VA3iqObeWrYFL2x9YU9OROP_
X-Proofpoint-ORIG-GUID: DTSkaca_VA3iqObeWrYFL2x9YU9OROP_
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 9/28/23 1:49 PM, Nicolas Morey wrote:
> On 9/28/23 17:39, Mark Haywood wrote:
>> I see v48.0 was tagged. Is it not a stable release?
>>
>> Thanks.
>> Mark
>>
> What is called stable releases here, are released based on a vXX.0 tag where fixes from newer releases are backported.
> But yes, v48.0 is a stable release in the sense it is a working release :)
>
> Nicolas

Thanks for the clarification. The reason I asked was that I usually see 
the the latest release on https://github.com/linux-rdma/rdma-core listed 
as one of the releases tagged as vXX.0. But it is currently listed as 
47.1 and I wanted to verify that there wasn't anything wrong with 48.0. 
Sounds like the answer is no.

Thanks.
Mark



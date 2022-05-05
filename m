Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6242451BCB9
	for <lists+linux-rdma@lfdr.de>; Thu,  5 May 2022 12:02:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354821AbiEEKGX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 5 May 2022 06:06:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbiEEKGV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 5 May 2022 06:06:21 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A80773FBE6
        for <linux-rdma@vger.kernel.org>; Thu,  5 May 2022 03:02:42 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2457b9h6032436;
        Thu, 5 May 2022 10:02:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 to : cc : from : subject : content-type : content-transfer-encoding :
 mime-version; s=corp-2021-07-09;
 bh=VyaiuWSPkURPISWx1FHrSskjzJ6z61DE4fVyigRF3fQ=;
 b=HpnwIer6kkk/rGdqlXRIDo9uEJBWQrE5jLQ1n8RbaNVqjetsTXIYf82T8PHQ+S9ZgNhD
 N6ZDfW4BwV2p1TkxebpRFqaT2MYTc4dnV5DLZLNsjtGB4hu9hs3AJOdrexHNH84zNasA
 r01HTCmdTvh8TMrScpVLIWT1Un+pxxwarl0ednnhvEhCkuozOOspZYcIryaoaUZLgq+f
 wReDu3RtpC/M4DIyXKF4Wuz5I9t3/6MmdBmZTOU/RqWelWW0XyfHl5sq8D/PMRbmOcZ6
 lEFnblLgYa1xkVeW0N/5ymX61zzSj3F/USMmWI4Y4H23B+0vGrq2Ik+Ja8glYLCfG2PF lw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3frw0atm2b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 May 2022 10:02:39 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 2459tZJl002249;
        Thu, 5 May 2022 10:02:38 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fusaggrtp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 May 2022 10:02:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d7Sl2cnR1O6HDi62SC3ruu6tDZsb1MnKQ8t76MReJ2ydAlxeAvEkdvY6QYXwtdrysHLiOLwhx6/eGnyh8gthLgiRgjq/XxdIopDCNeEe6jL+StBh+oMBiY9xf6jtD1sUzsJgzcamxxaaFEpQFwjw4ra6UHAKEpvHdTpy9uN/eu2IyQ9AZ/KfczH7O0EFuai9eEmOQeO1Okcx8QcsTzZDXGYAmhDLKplWgG2J+7DQvQoyDEwf6lLsLlU9q9gA2aoD0foFNM6ai+TSyTXxozVWDHi9K3VXu8pqeQjpa9qPAyqMWuDo+eEMngWMEeriYzKxAY8/OXCa0wdQ9fcB+lWRtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VyaiuWSPkURPISWx1FHrSskjzJ6z61DE4fVyigRF3fQ=;
 b=FMIYiUIx6L9NOJW+3U4sXxUvL6Sf9JyVO/0CJDPpvjHKa7ZSzsQ1RfeCp++J9IUGi8OZUjzOzcEf6qVFX17xtrOxaswvr4mCO9L6zFMdAyrudF+PgsomGDXP5D//ioWljkNtqvENDXTXtaKnLAd+hOviZMtPctkDpqcNGLjGbjQmNSdal77vOoMAHPDgqg4kQanBldPcJy0fNaB/shrYzQ+eGk0llWFwa5l/suVqDxMAtwH2yu0UigoDOcRkp9er8rPJDCFSepy3e+VqZwVl5gPP+Njo98Nl7iI7N2XfWfko6bwV2UZk+9anLhvnpJS7ajf5ozhZZ0X5uhjYC4o8xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VyaiuWSPkURPISWx1FHrSskjzJ6z61DE4fVyigRF3fQ=;
 b=B96cLYnXbFvIaqF/4ZVzsFtbRbLHqzFoc66uT7dLwOYEwr9nKfChRcnPCvbeQAI629eNxQuSIjQyJpoOHuXIs71gGWl9CaATOMgrYcdSTA/ZD3Adj/TfnoHC2AgaYIUgGjyCiBnL5Sd83bMbSPq0C224UWNPa8dM1okooSG81kY=
Received: from CY4PR1001MB2086.namprd10.prod.outlook.com
 (2603:10b6:910:49::39) by PH0PR10MB5546.namprd10.prod.outlook.com
 (2603:10b6:510:d9::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24; Thu, 5 May
 2022 10:02:36 +0000
Received: from CY4PR1001MB2086.namprd10.prod.outlook.com
 ([fe80::3066:64d3:664a:fcdf]) by CY4PR1001MB2086.namprd10.prod.outlook.com
 ([fe80::3066:64d3:664a:fcdf%7]) with mapi id 15.20.5186.028; Thu, 5 May 2022
 10:02:35 +0000
Message-ID: <057cdabf-997b-6f4a-6877-0be89254166b@oracle.com>
Date:   Thu, 5 May 2022 15:32:21 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Content-Language: en-US
To:     Linux RDMA <linux-rdma@vger.kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>
Cc:     Rama Nichanamatlu <rama.nichanamatlu@oracle.com>,
        Manjunath Patil <manjunath.b.patil@oracle.com>
From:   Anand Ashok Khoje <anand.a.khoje@oracle.com>
Subject: [RFC] Adding private data and private data len as argument to
 rdma_disconnect()
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2P153CA0032.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::19)
 To CY4PR1001MB2086.namprd10.prod.outlook.com (2603:10b6:910:49::39)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 54261aa2-a493-417b-0f5d-08da2e7e60f5
X-MS-TrafficTypeDiagnostic: PH0PR10MB5546:EE_
X-Microsoft-Antispam-PRVS: <PH0PR10MB55468F4DF465FEF640D4B571C5C29@PH0PR10MB5546.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S0dujqGpWxQGh/Dob/hq1+OjDZIDBPqzVtx9tKrOa5bGw+3f89v5Nvq0UwomJ0k622Ha97k7ktmPrIkrvI5YrjJCqkt3amRHYy0YxiB3uKLU6KTwHgqoHt6CwsgFs8mt3KJP52CGobUMsDJA2uv0+jBGvtCM1Io5O7lar5gPf1H6wB3nJoo7aEutpEhoOLTHm4cnnPkGZZlVjyC9GUDNagJGyp8SWpc0CsrqTaNCJQG/eeW2Vz4vfB9tjSUF1ClSmq3fp5EnuVOSZdFXfE+bm3MDDKNYg2BNzinbrnoy3Zh3lYUanAJ04GGu4LO3Mzd08aAufHm1ZRxN3CVEx1lqFevKe4qVkCpwsuWfXSovbpECG6ysvkrnYTRMwvXFuAd9uXGyvqL/vTs35awiqN0lK9NqxykZEb7/FKOiD4JfXzEGSN3H6UQ3KQ0J1PjyOWBzRHBNuCvlkNyKRjefbNVbLVM4gBK/wS44HKPXc9qWC6yTd9hvMxhjqACLCh6oB5JjBFaQhbAS9JJ27U45NXLS9FCwX/PXmCqcKr/hYLPEWB1RI3SDgsG0/bs92ikSBjEG02sItLNQEAuAVAxkbZ2b0MG1E4lJvnIFLiz/Hh6Z7ZoBJEKXITdVmXllXo2GOE6HpnLrpS2iuM5qmmlLJFYymcu9OxT2xlvPHy3Y8SIbG2OCQ0WpuKkUJnYL79ZPGjpXHBDCPUCL2t4h3nVkfjxIxjusgawCCsaZtxyb32VQiHs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1001MB2086.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8936002)(6512007)(38100700002)(6666004)(4744005)(4326008)(5660300002)(66476007)(66556008)(8676002)(31686004)(66946007)(31696002)(186003)(110136005)(2616005)(54906003)(6486002)(36756003)(508600001)(26005)(107886003)(316002)(86362001)(2906002)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cWlKMGtJaVdBeUhUSEJ1TkJvVGVLanNObHZGcXNNTVRpdS9mMVdQSmxzd2R5?=
 =?utf-8?B?U0ltS3VJWTRMSkNHTnZvemJqR1h3OUZpSzNnU0djR1JQSVFsbnRwS1Y4R0pq?=
 =?utf-8?B?S0E4NkwzMzhGdVNVd08rb1Yva2s1ZDlVelkyK3p0SVVaeWhKZERLdCtSNjQr?=
 =?utf-8?B?Rk5POVdyY2dFaWY0T0xYdnpsZnFweHRJdUxGczF3UStVcDhKUFNpYUJmY0lJ?=
 =?utf-8?B?cFk2TEFjK3dJaXAwcWFZalBuZTlPc3FtZ0dNRzhwZXlMc0YwVnFDbE9TWWll?=
 =?utf-8?B?V3RaenlOeXdwTUk1V2JvaXNtOTZIdHBPd1l6RVlMb1FsdWZFSDVWMUZGRkhM?=
 =?utf-8?B?OGllS3BXTUkwcFNZR2t3SDBYQ3doTTYybStrV0NJeXlJbW9SYTRXWlZsemhD?=
 =?utf-8?B?RGVyRDBrZ29PNW5EejVsQVZETEhIUUJJMlp4S2FrbUw1VGlaVUpCZ24rYnBY?=
 =?utf-8?B?ZTk3NE5RQnp3VnU0aG9idXZYNW1SWVZvRDBGMHBXOXVraVY1Z1NKUmRRYm5i?=
 =?utf-8?B?SC9uNzJYMHBSYTJIUjJvbHYxRUZsNnYyODk0YVhTOGI2Y1JrTU9RU3BUVGpQ?=
 =?utf-8?B?MXNCS3Q1ZGN6c3JYSVhockwvSVpWVHczYlBNNlZNeHBkR2I0bmxMQ3ZnUmlx?=
 =?utf-8?B?cWwwRWM1WWlrSVBhcDlHV2xXUkozVFZqcmc5eUxjN2RidlRFdERPcE9ob1Bv?=
 =?utf-8?B?ek9RbDlhNW9QUFJrNThHVll2RmJvdmR2eWxMcUZ1SS9MQ0JuQ1Y2U0x1Sk95?=
 =?utf-8?B?OXp0U2VvMzJ0T0tZS1ZXQ3BnWDY3MXM3TGhRc2hoZmoyQjRDTUk1ekVheTRX?=
 =?utf-8?B?c1F1cjdyVXh3b0RhUTM0cWVndndPUHQvTjJmNDV3ZUJQbmdQdzB1V1VaaHc0?=
 =?utf-8?B?SW5LbG5lVlRTMVhERHp3SFd5Q1pyeG1UMGhxL014d2QzMWdBaWdqTzdhdjZR?=
 =?utf-8?B?OHNVTHAxdHZ4V1IxUExxYUxNKzBvbjFOeUcxTHFXUTF2aFc3Kzc2Skg4Nk1R?=
 =?utf-8?B?NTFEUzFCL0ZnSUJ5SFRibzFqcm80ME1QMFJ0VTAzckhxZVMrQnFaK3BzYyts?=
 =?utf-8?B?bGVWUXlqZ0NJbmVNWmhMUjJmOThNclhtL3ErTlpjMmdvMzYwK2U2UG94MkFi?=
 =?utf-8?B?SFNoUXVkcHJMalhMbkk1TVowdU9KN0RPeVorMllpODZQdC8wdDFUNWY3cW5T?=
 =?utf-8?B?dEg0REIzTHpYUi9jc0ZPSWNuVFVud2tsb0VCY2QwS0RXK0s1Q3RNY00rY00x?=
 =?utf-8?B?Smo3WVJxK0dWRnhoK1VTVUMxSGxqWmNBUnFrNkJXM0Z6WnBpTWJkcjJwYk9N?=
 =?utf-8?B?T3JISWJJYjIwZitTREJqRHo5U09PLzhEc1NkOHRzZ1NhN3JwSXdteExBb3JC?=
 =?utf-8?B?OWZXdHVJZFkrTGdNUEdBTzBPaUpNdXp5ZFdKMCt6VTZlOUl1WG5aTFB3cVlt?=
 =?utf-8?B?ejhRYllCVVpNU1pHOVpXU01HeUFaUmJVNHlvUnV0ZGZxVlR0c0MxMkVkdVdQ?=
 =?utf-8?B?eW9HY3hJQnY4Vi9jNnFDaVR5ZHRaMGdHMk4rOCtGSVZnZnc0L1NQNUtNSzd6?=
 =?utf-8?B?c3k2MWpRdEsybUNndVh3Z3JhV2xLejMyVVpUV1hWa3kzOWYrODUvWCt3SEVy?=
 =?utf-8?B?OXpnUDRTVjZ3RnAwVEdsbFRwMGNISnp5Qm56b2xGb0p0TlNpbGp2THJKdUFX?=
 =?utf-8?B?b2UybnRMcDI3aHBxYTA4eC8rYkZjSlUzK2Q1bEUyWWJvVFBEMjZKL1ZTOVlr?=
 =?utf-8?B?RnNMMUk3K01nSDVVTENtM0VKa0VuK29qS3h1Vy9ZOWZxWHQ5TDZ2dUZwYmZZ?=
 =?utf-8?B?SzNHYXVMZWFXT1J5S2pmU2tEWFRhNUd4ejhtQTQralE0TTdWNmdKNWRYMVZS?=
 =?utf-8?B?Tlp3Q1NRUGVkZWFYTTBnVld5dko3SmVWN2tCRmVqRVBTUm5nNmFjaFNoZWlo?=
 =?utf-8?B?Mnp2TlRIZ2pJNmpCR0lxK0tXdmRFMXNOUWJiUk1wVXhFM0FJK3J1R21EQzdF?=
 =?utf-8?B?YXV6SytMR3YzUFROdktlR1lEbW9RNGVTSnVHc3pCZ1NoazgrUkcvc1VkZnBj?=
 =?utf-8?B?N0p0WG9KZHltT3NTY1pRcm91TUNHclJmSTY4THROSVVFTjZoVDU0Ty9GbFhB?=
 =?utf-8?B?TlIxZ0RjWGtPUUhwNEI1eDJ1aWdnNFhKT0NUSDdGNmFDck5HVjZldUloTDd3?=
 =?utf-8?B?d1V1c1BnS0kwNFd3d3JIeEprQnFaMytuUUQvbExQdVgxZnRJaXlCTTZMUzJo?=
 =?utf-8?B?QTVJcDA3R1d5bURKMHRwTTRqNEhQY3p3TFNjaDNZME9QZUlRd1hkTWE4RTl5?=
 =?utf-8?B?aldXZkw3Skh3UUVieDl2NisvblF5aHpZK0N6UVdoSHhFdWI3cnlWcnpxbGsz?=
 =?utf-8?Q?YpcM3GuaJVJGCd6A=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54261aa2-a493-417b-0f5d-08da2e7e60f5
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1001MB2086.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2022 10:02:35.7838
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9qA6gVNbQqV1PSZ3R2vsL+EQ9BAzcR8qGqHwEof5zGgJ5FemqyFVDJy9mDAVjW/2RzYP4JszGtJ6S8dFOHngcjAGr9O59gHvRfpG9KTry1k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5546
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-05_04:2022-05-05,2022-05-05 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 adultscore=0
 bulkscore=0 phishscore=0 mlxlogscore=999 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205050070
X-Proofpoint-GUID: tAp3pB--O_clIsXZ_T9pu4u5iz275k2G
X-Proofpoint-ORIG-GUID: tAp3pB--O_clIsXZ_T9pu4u5iz275k2G
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi,

I just wanted to float an idea for an enhancement and get opinions.

There is a provision in ib_cm layer API ib_send_cm_dreq() to send a
private_data along with the DREQ.
This private_data is helpful in situations where the receiver of DREQ 
may want
to understand the reason for the DREQ and do some action on the basis of 
that
reason.
We have come across issues where it was critical for the RDS code to 
understand
the reason behind a DREQ and recover/tweak some parameters.

Now, rdma_cm layer has a wrapper around ib_send_cm_dreq() i.e 
rdma_disconnect().
rdma_disconnect() is used by the consumers of rdma_cm. rdma_disconnect() 
does
not have an argument that accepts private data. Due to this, consumers 
are not
able to use this feature.

In case if we add the arguments private_data and private_data_length to
rds_disconnect(), the only challenge would be to add those to the callers
of it (NULL and 0).

Please let me know your thoughts on this.

Thanks
Anand


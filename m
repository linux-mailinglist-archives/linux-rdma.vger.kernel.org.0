Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B96F4525A88
	for <lists+linux-rdma@lfdr.de>; Fri, 13 May 2022 06:10:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242288AbiEMEKf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 13 May 2022 00:10:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241948AbiEMEKe (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 13 May 2022 00:10:34 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8D805C36F
        for <linux-rdma@vger.kernel.org>; Thu, 12 May 2022 21:10:33 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24CNc5r8007656;
        Fri, 13 May 2022 04:10:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=QoYddts6mZHcR94JqE9HyBSb9SvXj+AlZz+YBmssLUk=;
 b=ssC+Ouew5UMk/PW/AVVnUqIFWpR+ecWGU6uM3D/rpQ6TTla8rw9VS/37ibBDDVWu4yNU
 bCj1YGReACLcDmP+ZNCIwlas5CgNYgaeCqhmKYXspjpmh93FN22pCVaZzK7EBMI7rLN3
 2lCwSd62yRzHbVS1iqD29rjF0ZMlvQ0QTybBKB8R86e1tOsLLx+vogcGJeKNilSkjXMW
 gvKXt/cTX+Znc+tYzLe7g/QmnQivdkIWhrtT8ITb+ZmFckr0fJlQGmXkhn+unBgdCTp+
 dL+FURhIkytYR9PmJJloFtzLRIPlvQlzCx1GOEmj9TR7G75wQcnBpteXSI4t+g6wD/oO AQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fwgn9ww9u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 May 2022 04:10:31 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24D45IFQ005799;
        Fri, 13 May 2022 04:10:29 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fyg6gqwke-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 May 2022 04:10:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NVPe+qoPsZSnfcFASCSakQS5WPc8M/yxVpcyCsKvtOs2QhIQZfFBnhwbA1H0/rWgnaRsJeSYszxpUfHhH5nKt2oI+V8qRCKqT+9v/ZhBoUJ+6ZtFdwJLhcQwTgr5fC+HRyclmbyNPeb4sucnRkReJ+CtIG7zR2If3FZ467RbCb9weh1qZBdEPsh85XbVKzQuSb3idbOEQkueBJ59CsHODAcNhLi7xh2P95AIq/onuTOaoseNu2iY6Wk1MJMFWYfCISHA2i7FBs/CtdbpH4dQG5mkLfPaYo0kofVFwASPV+wb2Tsrx9cvjXZN5kxCO46f0OeMFrjJEYno9MslT+69oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QoYddts6mZHcR94JqE9HyBSb9SvXj+AlZz+YBmssLUk=;
 b=Vl0mGuF8ApvOWd6Iw+t3rv+LE0f5F8Ij/ffPHWF+NBPM6mtO1h6HEaQDoIJGZiFLFwoQex5FImv7Fpozuk4MmCwXkV0/q6CrS4X0eRnQmWglp6LKYMRiloLvagfCW5/gyEW+mVu0YegArgI+c3R6vASiJYMubZNhBzGf+EwX2aSnBT4k/flFHnCEmhbeDK66bpWSC3ru7VOMpFNjVXhSC0XyOezhvVJ3dPFz33u8WcZ96TYM/yH1WtpkXdwGwautBCNhztMIKv6NXnNaFJFcSO6nDb3+3oQdian7ZAhQEcLXb7+lW0qEp9iIj4SrPw+UjKcdxji0saz3KiZtVdhPnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QoYddts6mZHcR94JqE9HyBSb9SvXj+AlZz+YBmssLUk=;
 b=DxJzz6ybDXgeq15mv+Z1ANyoulJsE2VzGFoiJY6lMY3F8V6A2RGCO7bJFW+k3a9f9kKUTOkQJFUl/sbRzg3f9e/3wl46PK7xbWJ7xzCb6LxEGN+avHciFrPiwtOeH/RtqBFiLYoj5xo/1WPcMuJK/kBQSTRV1Ka0WbNBYRIpTME=
Received: from CY4PR1001MB2086.namprd10.prod.outlook.com
 (2603:10b6:910:49::39) by DM6PR10MB4268.namprd10.prod.outlook.com
 (2603:10b6:5:220::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.14; Fri, 13 May
 2022 04:10:28 +0000
Received: from CY4PR1001MB2086.namprd10.prod.outlook.com
 ([fe80::3066:64d3:664a:fcdf]) by CY4PR1001MB2086.namprd10.prod.outlook.com
 ([fe80::3066:64d3:664a:fcdf%7]) with mapi id 15.20.5227.023; Fri, 13 May 2022
 04:10:28 +0000
Message-ID: <22a2ee27-fe80-fc64-6838-0dd272288c46@oracle.com>
Date:   Fri, 13 May 2022 09:40:14 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [RFC] Adding private data and private data len as argument to
 rdma_disconnect()
Content-Language: en-US
From:   Anand Ashok Khoje <anand.a.khoje@oracle.com>
To:     Linux RDMA <linux-rdma@vger.kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>
Cc:     Rama Nichanamatlu <rama.nichanamatlu@oracle.com>,
        Manjunath Patil <manjunath.b.patil@oracle.com>
References: <057cdabf-997b-6f4a-6877-0be89254166b@oracle.com>
In-Reply-To: <057cdabf-997b-6f4a-6877-0be89254166b@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0053.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:98::14) To CY4PR1001MB2086.namprd10.prod.outlook.com
 (2603:10b6:910:49::39)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d7575fad-9257-47bd-f3c2-08da34968089
X-MS-TrafficTypeDiagnostic: DM6PR10MB4268:EE_
X-Microsoft-Antispam-PRVS: <DM6PR10MB426844D4F5CD38C35ED0AFF0C5CA9@DM6PR10MB4268.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r7MZ9IXggLFaOg5ibSDXZGGd9aVRzF0Xulc86B60FJyjwlOp3ZSh7LLRqoEwDBX2MLByH+bpmJ2o93UD3AAakikCUE1So7w68KfEAQZN5acqi6DeFGLQ8+9O6BVXmIQoQ5H3eQ1YSqVn7UC4g0v1LNOo+4v0wWcWu7SRBLq73+8h3dxhpvPg6XTL/T5u95EPl74xdHHAwsGUISnDqFzoT0JrZjcUI2KCgxk/XSMPEORc38eGBuhD+DbNQtzl75a6ydEYhzPXmXedB44qESVIAhp6A2hytQZD3p4ioc+o6uifIxiAFtKsNLaOpvb3srWrIspq7bK2b0Ii1CMV/jTk78ioH2M/ohqZP4l+NwKsgjKAKATwZ8yClSBGUW8gdFhOb9wT28RE3vKKfeGF186KPlGN6lE0EY6Z8LEtBQ1/BtziIQmkQAsF+SSlPQ/vC829D/pRR7KyfkJ2tD6hPUosX9SF3156CvpuN0Z30O+TEL5NNWDIv7igDM/lPlCYPhVg0fSFjgSKhz+GKWyhWHpEiM/A2pcJA5G40ZG6yuxrszSJ3Z4NbkqqhC6CBCXWyF9oFH+V0o7syFEmCZJ36WWOCRdy+AoztOq0ovmSaXkdvmO3Hn3StfU57Ya5I4vTmAD1wErMpKm40P19aoEjFRZzWh6x/iQ/PMQ0KRAtbd9ryy6QHt0NVu8jA4kvzdLGsnhhYt5//mUAVrbuXpusI8MISF3qKZdfZuFsH4TvcDB3DdY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1001MB2086.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(31686004)(6506007)(186003)(2906002)(83380400001)(53546011)(36756003)(86362001)(31696002)(6486002)(8936002)(5660300002)(6666004)(508600001)(2616005)(4326008)(6512007)(8676002)(316002)(26005)(107886003)(66946007)(66476007)(66556008)(54906003)(38100700002)(110136005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bDZvOEp6cHNXaXlhOVFXeGc0QmV6dUl2SnREUHhJbmVlMkZhTWRRVy9GRWtS?=
 =?utf-8?B?ZkMrQ1dXeVpHSk0xTkxmZ0Vzb0FJOTR2SC80b1FrOWkxdDl6QkxLcFl0OWpO?=
 =?utf-8?B?cllHM2wvZVdweDN4VGdyVzRoUE1BVy80OEtTUlYrczc5b1VuSGoyM3NIL1JH?=
 =?utf-8?B?aGNpVk94djFrSWZrTkc1Q1liOVBrQkx3SU1vTG8vWTQ5aGxGcGFjUXVyM2Q0?=
 =?utf-8?B?MW53d1cwRXE1UmNzc253VWJ1R0F5RzlzemxRdFZ5YW5rYmdHQ2RndWV3dlc2?=
 =?utf-8?B?cWpJcDlrMHhlR1BLWFV5RzNubFVEWVRBUFhJUFhBeGNrUVp0QTJLZHQrYzhQ?=
 =?utf-8?B?Y256VmYrMDZicXBQb1JJUmZONWMxUG1ia3J2TlhranJ3R3NHNzZtYmFxdWo4?=
 =?utf-8?B?VnNaa0pqd3p3aVorZVZvSWNUdjNNQkVEOTdFd0k5aFZ0dWFsR0RjWHN2VVJt?=
 =?utf-8?B?K0lWMGtMRW5ibWN6V3dVQlV1d2NaaVNDcGJ6RUdqenl1V01VNHp5NzNtOUZi?=
 =?utf-8?B?U09nN0djUGlIUzA0bU5JRmRxS0NPLzc1VER6QmZteVc0UTk2aGcyUm1MZCth?=
 =?utf-8?B?alFNK2tvc1h2M2hWMldNbnRESFdoVjgydEhLbGpaV0c0SjFyWDRCTFU2RW10?=
 =?utf-8?B?MXVWWHJsNGJOSkNURDlSSnVRRVdtK0dXU0hzTXN6NnFLOFpkcUFEL08yQ2l1?=
 =?utf-8?B?NUxocVRRVDVUaFJhVzVmZmVHN0gvN0dSMVd5NCsxWW1hQUd5RWgzc1U5bGh2?=
 =?utf-8?B?VFlUb0lHYWJna1lPLzlBMURuY0Y3RG51U09KaWZpdTUveWFxV1g4NGdaMzM4?=
 =?utf-8?B?VWxKbDlzNGk2bngrOHcrQ1hhRm9iWFVYZnlaMENVNDloem52akdWWTJ4WVlF?=
 =?utf-8?B?OFdQT0RxZDBhSC9palZDb015T3p3TGdPd0ltblp6cHltYy9HTTBFM3YrYzR0?=
 =?utf-8?B?aFdqUi9GajJ3MXJGb2hzcnhHeGtKVVh1VUdCQ20yTE0yVDRGUGtZMkhUeThF?=
 =?utf-8?B?OGtEVkN5Q21QV3RoN0ZCdU5NOGRHR05tcm5pbzRYN1ZYMncxc3hkWUU0TEo3?=
 =?utf-8?B?UHdjQ3dnYzF6WmVENWZ6NXZ0Vm9WODFrMmh5RHgwWWdiME9GTnJtay9HSm1s?=
 =?utf-8?B?WEgrZnRjSkFWc2VDN3lyR2ZqN01NTkhsZDNqWHU0VWU3amlwakpNSi8ycU1p?=
 =?utf-8?B?czdldnhJMVE1N2tlb0dBc1lmemVCb01STWtrbHQzcVY0R0t1MUJVZ2VFd3pI?=
 =?utf-8?B?NXl2STVQR2xrL0h0R2lVYTZQTVFuVFJqSnIzclJkbkp0TGlnNXV6RHJiTUlE?=
 =?utf-8?B?c0s0bnovU0xqdVVkR0FXeHFNaXpmZWVTV0VHelU3OCttL0F2dlQwcDBUN0Zp?=
 =?utf-8?B?Y2I4SkhveGlvOFE1U0Y3OFBEMW1hV0E3N1RRSjVnZytEQWNZNWpvQ3BuQlg5?=
 =?utf-8?B?a2NoMjJtRUxUWXZmMDRHS3Q1d1ZLZU1rUXp2QlFON1BqS2dHQkJqV21xSXI2?=
 =?utf-8?B?elZiTjBYNThTbkIycU9yYmNVUnR4ckduU0o5Vmk2a0Y4MGQzaGVRL0JjK3RF?=
 =?utf-8?B?cExZWVUzZloxV1pIUTlkV3FxOHAxL0Nrdys1NllRTUxKeDNVU1FCNFE5OWxH?=
 =?utf-8?B?Yi9jVHNEcVlJZ1Q2K0JIOWhMNlVkcjNOTjFZOVVuMWRYc0FTb3VubS9xeHQ2?=
 =?utf-8?B?RXU2MFovb2MvdDFYZ2VxQWhvRG9OUVBqZzlTOGpVK3NmL3RVOVVjN2htbTJx?=
 =?utf-8?B?WEEreEszVXNCMWpTQi9MeEljd0RYd2xwcTJpbTZTMU1ROFl0dHdtbTFWQjc4?=
 =?utf-8?B?Q2JjNm1vMkFrOFVEaUs2aTVTRVJXSXVzcHhES2dWakJCRzNmYzFKOEZGeDZE?=
 =?utf-8?B?UklJMTBDTlltS3ZqL1p5Sjd2YnNVZCtqYkFGR3lqT0I1Yk9QTG9mekF3VERu?=
 =?utf-8?B?VlRlanJTWHFFZVdoQk5VanNLZ2hOalVrdjZuVGdOYVIzWEgxRm9vSkVMYkhG?=
 =?utf-8?B?Y0wzS3F6alZZbHBxN0lUcVBwamF1RFRCUXA1VldicnBQeEZwN0tjZTRuekJ2?=
 =?utf-8?B?QmZPMmFtVnNzM1NSQzRwU1UzcElBbHI1SWkwTHFKTVc1TXZSdFpzcmxrSkM2?=
 =?utf-8?B?Vit3NVhOMmY3dUVVNGVBQy9VM25LYllCMTFhaCttNk1EVzMyREcwbVYwMWxv?=
 =?utf-8?B?WlhQVUIwN05OSW9Xb2Z3Q0dzZnNGMkFjK2cxL3U0SDllNFVScUIvZHBtY09J?=
 =?utf-8?B?emhmc2V2UTVCUUNHRmhZSEU2bkp4SVVjeVdRZkFudTB3WUowSFdhNTdyZHJl?=
 =?utf-8?B?Zk5ZcVNyazkyMG9qb2dyWFpQeFZveWdGSjJObzBrenIwV2FCWStoYnRBdHlU?=
 =?utf-8?Q?oZtvchIvQLr3kzPc=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7575fad-9257-47bd-f3c2-08da34968089
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1001MB2086.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2022 04:10:28.0418
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ccTAuri30iYSOuhssjqE/D6GrckVoXCwdAHS/upFDxoIiZC9s0UnB25ap1lkvmGfkckrmQfVvkjG3SeGaTbp9CLVSiOFJpxmXhBWnvCGLIA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4268
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-12_15:2022-05-12,2022-05-12 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 phishscore=0 spamscore=0 bulkscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205130020
X-Proofpoint-GUID: dCHa8ofzn7HIcYAma8uleshQ-5U57vgJ
X-Proofpoint-ORIG-GUID: dCHa8ofzn7HIcYAma8uleshQ-5U57vgJ
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi,


A kind reminder.


Thanks,

Anand

On 5/5/22 15:32, Anand Ashok Khoje wrote:
> Hi,
>
> I just wanted to float an idea for an enhancement and get opinions.
>
> There is a provision in ib_cm layer API ib_send_cm_dreq() to send a
> private_data along with the DREQ.
> This private_data is helpful in situations where the receiver of DREQ 
> may want
> to understand the reason for the DREQ and do some action on the basis 
> of that
> reason.
> We have come across issues where it was critical for the RDS code to 
> understand
> the reason behind a DREQ and recover/tweak some parameters.
>
> Now, rdma_cm layer has a wrapper around ib_send_cm_dreq() i.e 
> rdma_disconnect().
> rdma_disconnect() is used by the consumers of rdma_cm. 
> rdma_disconnect() does
> not have an argument that accepts private data. Due to this, consumers 
> are not
> able to use this feature.
>
> In case if we add the arguments private_data and private_data_length to
> rds_disconnect(), the only challenge would be to add those to the callers
> of it (NULL and 0).
>
> Please let me know your thoughts on this.
>
> Thanks
> Anand
>

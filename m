Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4641E52764A
	for <lists+linux-rdma@lfdr.de>; Sun, 15 May 2022 09:36:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235639AbiEOHgT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 15 May 2022 03:36:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbiEOHgR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 15 May 2022 03:36:17 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2044.outbound.protection.outlook.com [40.107.93.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF06115FD3;
        Sun, 15 May 2022 00:36:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cL1/5JGG3N4VfWQWd/If7K+V0M8tib0HDmkh7E/l+qej1FgRMdGOXzaToS3w7JTO/RgB5R5tyi3cOBMO42iRzCXEFpJxS/5AK4C1JB26xYT5Oyg1PhSd/9CxAIB4CC/YRV8sGyQ68BQ1cGLsVgmvUNxx5JB0jUumuOtQSb9cjxb1/H1sA3kcs7feEZ6jDX6qpRI3JBHPrwx4kjPoSZyCbMYfuAhIDRAT+z+v8iWvGs81L21vVcho7SaY/4tAwRhNaOieMygUKEGkrO20DWh8BArJ9VoQk/xSo2c7NAYZi72nDTu7eYM1H5R1Oj6pkMT8C7MvaGd1NtSYKjXdcDA2ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/i9i70I9TFlULu08x1QMpdPsVvLXUk3Gz+PomIDfIO8=;
 b=jae+vUK6UGoyA5jfOmqbRMjnjnA0Oqf8ZUydOlEvgPEhvEKtWWFzRnnlF7/DIUMOdM6zbFN0OHqsDm5fTjgVKtnB1mj0nVJrjlNLRaDkSpPoeBCF1/YR3BjhDuhy0wsut2jRAY0xgNvEx4befcmLDw/5LKc5N4qlP6HkpPaSY1T0/2s+qUEH4Y+c5vLJZZ6XW2kX27Nwi3TineWyHCDCTo8V63dfUBAl2b0l0jC0rRXGu5iYh7obe92DJq6wQ0jiLdXAFz1XFPgYWBOYcGtceAuiC4b2+JPqyy4QbSFlpO1gGcXH3Pm2Ly+yYR3BEC3cy7Ue2JPGXMikU4E/Xr/qmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/i9i70I9TFlULu08x1QMpdPsVvLXUk3Gz+PomIDfIO8=;
 b=f+88JzaCZHvVaU99d7KsbGaA7+4R8mAvxUgXT0cx1FrrZMuudBT6muG78TTvetLFUzYl7loO1xNod6xj7P92MUkCunTTuflA38btTGf6/XRq54dvTrFd/VQL0w5bH3n0O8hNSWckndUL0R79GuJN/0NW+hnfcBb4IrjHbM4HaWL4fEwcvzxZqdtuIkBdwSw8FDxHk77O5yrf86ae4XxBDhdZwzH3m/XV59BPRUnrM6DmBO+WteH5fjgItoYCG+Xep27Nzq7wfUFu0s1z5WzB2BH9KeLaGygilSGkMk6R6Ndsj1FS1x/CKElOOtZjV4pJPt0VPDj+2rJiopio0VFC4w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN9PR12MB5258.namprd12.prod.outlook.com (2603:10b6:408:11f::20)
 by MWHPR12MB1632.namprd12.prod.outlook.com (2603:10b6:301:10::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13; Sun, 15 May
 2022 07:36:13 +0000
Received: from BN9PR12MB5258.namprd12.prod.outlook.com
 ([fe80::8c43:5d94:8809:ad74]) by BN9PR12MB5258.namprd12.prod.outlook.com
 ([fe80::8c43:5d94:8809:ad74%4]) with mapi id 15.20.5250.018; Sun, 15 May 2022
 07:36:13 +0000
Message-ID: <d37309bd-c7e0-8e15-bae9-9341f4f9192d@nvidia.com>
Date:   Sun, 15 May 2022 10:36:07 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] net/mlx5: Add sysfs entry for vhca to
 /sys/class/infiniband/mlx5
Content-Language: en-US
To:     Leon Romanovsky <leon@kernel.org>,
        Rohit Sajan Kumar <rohit.sajan.kumar@oracle.com>
Cc:     "matanb@mellanox.com" <matanb@mellanox.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "sean.hefty@intel.com" <sean.hefty@intel.com>,
        "hal.rosenstock@gmail.com" <hal.rosenstock@gmail.com>,
        Manjunath Patil <manjunath.b.patil@oracle.com>,
        Rama Nichanamatlu <rama.nichanamatlu@oracle.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1652137257-5614-1-git-send-email-rohit.sajan.kumar@oracle.com>
 <BYAPR10MB2997DF974EF3631A2E69CA3CDCCA9@BYAPR10MB2997.namprd10.prod.outlook.com>
 <Yn85iFNS96yO2ISD@unreal>
From:   Mark Bloch <mbloch@nvidia.com>
In-Reply-To: <Yn85iFNS96yO2ISD@unreal>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0036.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:151::23) To BN9PR12MB5258.namprd12.prod.outlook.com
 (2603:10b6:408:11f::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 20ff4953-c0b4-4cb3-3a14-08da36459657
X-MS-TrafficTypeDiagnostic: MWHPR12MB1632:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB163200BCF0F7C27D2ED0196DAFCC9@MWHPR12MB1632.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7g0lI2DI+bPDVv/l1bLW/hG5D8l5VXTAkxGVBnJ2OwMaDsUcSKxRBMv28YkbeaM/5cJ4lOhVBuf5OjuzvYGJ2tW/wr815Hc2bc7ul4wuqScF92mEq4V2FCGNgSVS0ngOm5EFvrZI8vjyZ3vHlr1V2qb8eGF2KNGRmZDzL6hycHAmYHEmNTUUihia3AxDjw0KcKc3MIl/g2iUJrV+nJ52GIV5qaDzSZWnzew4Hf96Q+0wr6Kz9VKb1DB21O5qKj4btocG5E6EV6GL0VmRSVuzgKqVFtLqPyx5hv6Qt44h9dc+hHuXNDRL2mZsDLa2BZUGw4cAig3550ZtU1mVFUjEee2lIQrkq7y8clxksNS3bqUUvZX4nwJs8mAEwj6JZWRrZOo2qQNR3702RtDL0reVLGjOwyGSxshTck6yuQI2983G3Ik7ENjre0+MPcBUFMY1YLBbdWc/wr1vTFg14I3IWvbvV2fqkWaRFskneS5tBEskhcChdRz1S7TsFRgg3X5ZevmwyicBN9BOYh0KcTR25G2EkVJVmnGtCPkLYUT+BMsqVn+9SBwZ8I8WROQ/TRgQvtTqa5XMBtdRsIeyS4nA0AViMN5Wur2VTZ11TMQDVviyfXwMqsdL70Zw10Vg3lsmO0U1t3gZ9ur61WA+3NUSJFghQkeggzdEDIvS5pc8HZXOs13jn5kVjeDaVLRx7asj3UG6JCuczuwnutO27XMWuen535++9kYXrZZpJxSabck=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5258.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(83380400001)(2906002)(66946007)(5660300002)(6666004)(8936002)(38100700002)(6486002)(55236004)(508600001)(53546011)(6506007)(8676002)(31696002)(54906003)(86362001)(110136005)(316002)(2616005)(186003)(66476007)(66556008)(31686004)(36756003)(26005)(6512007)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UVNJNDl3YkppV25xSUJTSjVVWjdJS0lSNUpwRTR4SUxwcm5YL3phcElEVjh3?=
 =?utf-8?B?bmFmTmd2ejlIdmhkLzNzdWRldkFhRHNFeDJWWGJHUXNra2FCaU1ReU5VV1JN?=
 =?utf-8?B?aVV1L2plZ1h5NXA0VU1neTRmM3B5d2U1MjVpemhwSmc1alZvWnFFV3loSVh0?=
 =?utf-8?B?M1V6a0JnK0J1Rk44OEI4VEU3ZmxQY3RORC9IR1Y0Q0p6TERReE9oS0NRWnBm?=
 =?utf-8?B?eWVUVFhQemtOa3VlY05Tbkpoa093M1dCKzd6dTFSNlRnMnpYVVRsVnAxdURy?=
 =?utf-8?B?ZnJQYmtIZUh1ZFRtdWxuWFR3emhUMDAvVE4zaVlVbiszZm1hTm1uUXUySDhu?=
 =?utf-8?B?Z04rVk5wbXczbmJBL2ljQTZDL09Sc0g0YzkrY0ZEVGRxRnFLUXpOYWdWV0pU?=
 =?utf-8?B?d1UzTmhpQ0dEaERCUUxXTldrNi9kQ1Q5d2YzSDU2Uit0UXNhNUhuU1hiUVpU?=
 =?utf-8?B?bVNoTjl5eC85YmovQUE4TWlOZlF2SjNQdm1iVHpzY0swSDhiMGdPdUdrQUpv?=
 =?utf-8?B?LzVpOVROQnNFNElITElmU1J6Z1oxcCsxcmNBcitZbXZvUWRrR0lrbE1QcDR5?=
 =?utf-8?B?QXV2NWpwZGhkNThBYXdaV2J6ZStvb0N4NS9mV0NmQm42cnpjL3d5bWg0RTh0?=
 =?utf-8?B?eVpWY2pTT2dsN0xxMUFCbUJ4YU1BeWFCUVF2T1k0Ly9hS3FTM3UwTmtROFN3?=
 =?utf-8?B?U3ZIZ2s0am01RjJIK0t0dUtzN04yKzI2SGlsbDh1R2dkWks0akNnSDF2aWVY?=
 =?utf-8?B?dDBCT2Rtd0U0NHJjdXk3aG5yVEd0emZtbDYwVHRKRXdOM1QvdTU1Tll1K1FQ?=
 =?utf-8?B?elJFVTFvOFNFSDM4UC9uVkNabllCSzd5WEdIajJvYkh2a2JtczJ5cHNIWUkw?=
 =?utf-8?B?S05KZHZCbnhPdGE2aVM4dGEvUEViSDBDeTQvTTZyU0dPeUhaR1J5WWlHUmdP?=
 =?utf-8?B?L3haUWVjbW9JQ0t2VmN2Z3AyL1UwVHNjVWozeXJKMWZzTVJpYTc1bWFqUlU5?=
 =?utf-8?B?KzRaZ0hvWDlpSG0wUzZFRHBrZk9zZXp0ekszZlVZQWFBVDAzT2VpeVI2clMx?=
 =?utf-8?B?MFZzMTBjTGZmT2JFMGtxRm45TXJQS0hzNy8veFlKZDdxYjNPYmFwQjJqL1Z4?=
 =?utf-8?B?ZXYyekJBTUpwL3ZBY1E3YktSN2VlYU9pcy9GSHoxMU00Y1h5VVQvN2dZRVd1?=
 =?utf-8?B?TFFtWTVOUFYydmo4eStoWXd1YTBhR05pc0pwQU10aURrQlg3am9NaGtEVTNl?=
 =?utf-8?B?RFJHUG5tU2lkY3VMWmFNcUJFbXYvYlpQMkQydVA0ektKSW9sMW5pQ3J0ZlRK?=
 =?utf-8?B?MjAxYnQyRkllaWxuUHFyaEFKK2xXaW5vc29ReFIyUmM4OGRwSTRuUDlqNUky?=
 =?utf-8?B?dVU5WExDcndvRUViVWoxSkNqR2FhOThIWFpsbEdWYkN1Z2JXUVpzOTYvWTl5?=
 =?utf-8?B?UFR3N0NMUEVmODIzbzFobVkrVzBDQzV6b3U2bEpIWlpMNkN5ZzdpZGtQZ1gw?=
 =?utf-8?B?Rm0yb1lkZmFRUklRSWhHOVgrZlZuOEQwZUVGRU8xbmdZOVBSd3QxUkNraitJ?=
 =?utf-8?B?QlR5VUVCbGtZYTZuQXY4SUpwY0tGblJKUENUODFIZzNVQUdMRzd2dWk3NzVu?=
 =?utf-8?B?NzF6a2ZhaG1iM2lYSE11ZWxTb3hSak9iUzY0Uk9JN3dKcXU1NVhva2hBWXpK?=
 =?utf-8?B?L2lPWUJzVjlLWkZwWFMxOEllcnBLb0lBYk5vSTAyMW9TdS9qZGMreTlwN2Zz?=
 =?utf-8?B?djBoWmlMZElxL2JSbTRhVFBKaFRFaWVNbXdzU3dYWHlocUE4bW0xUU5XWTVK?=
 =?utf-8?B?YzZpdGFQTGVQSnY1MXpnWnF4REVCTEo4TWFxS2h0MlFRQ0FiaEk5VWRmK0sv?=
 =?utf-8?B?cWRUbGJ4ZU5SNEJVakpzQVRlSG9OeDNIWEdZNlVQVUpaZ3VVVnRlSE5xSnI5?=
 =?utf-8?B?RjFHcDc1QnZubWZ2Q25xZ3RUTHhoK21KMHBDSDh1Qy9XV3lza1dDVExLUEE5?=
 =?utf-8?B?Ujl5aEdiR2pqYXdIUEcxKzVXcE1lZU5tU2JQYUhGQWJxNEhxN3B1Y0RxVk1w?=
 =?utf-8?B?d05aQVJic1QrN2pwaDNBdGppMjgwbzV6aytmcHhEcFpXcGUyQ0h6eFRqeVFM?=
 =?utf-8?B?Y2t5OXJCaHZvcVpUQWtLVllwTituT01hd1ArcDRpcHRvK0RSOEEzeWJLMTE2?=
 =?utf-8?B?QnE5ZlIyN3g5V3hQVDl6WUI3S09Wc1JTSGxhUTBncGJOQS83SVFvRE9kRlUv?=
 =?utf-8?B?KzA4aXcvdDBxS3hGQm5TeWlEUG43aG0yS0VWYU5ZZENJYjU0K0Y4Z1JwbW1s?=
 =?utf-8?B?QWJOSjdMdFNlUmpvNjdCZEVzZjNzMW9LdjJUdXdqUWNGejRmUzFSZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20ff4953-c0b4-4cb3-3a14-08da36459657
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5258.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2022 07:36:13.1787
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WEtNkZZWVcpR1jYi8UxWnKFDpP9LS9J78D7g7klkfZcceJEZBpC+pjbIkvxPoHzdJH20r32fsL+7iKK00NBBbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1632
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 5/14/2022 08:09, Leon Romanovsky wrote:
> On Fri, May 13, 2022 at 05:46:16PM +0000, Rohit Sajan Kumar wrote:
>> Hey,
>>
>> Sending this as a gentle reminder to review the patch sent earlier this week which can be found in this email chain.
> 
> Patches that sent in HTML format, to wrong addresses and not visible
> in patchworks/ML, without target net-next/rdma-next/e.t.c., with wrong
> title are generally ignored.
> 
> Why vhca_id that returned from MLX5_IB_METHOD_QUERY_PORT is not enough?

The driver returns that only when in switchdev mode.
I don't see why that can't be changed but that's the state today.

> 
> Anyway, sysfs file in IB driver for the property of mlx5_core is no-go.

For vhca_id a nicer route is probably to use DEVX and and run a mlx5dv_devx_general_cmd()
where you query HCA_CAP and take vhca_id from there. The added bonus is that
there is no change required in rdma-core/kernel.

Mark 

> 
> Thanks
> 
>>
>> Thank you.
>>
>> Best,
>> Rohit.
>> ________________________________
>> From: Rohit Nair <rohit.sajan.kumar@oracle.com>
>> Sent: Monday, May 9, 2022 4:00 PM
>> To: matanb@mellanox.com <matanb@mellanox.com>; leonro@mellanox.com <leonro@mellanox.com>; dledford@redhat.com <dledford@redhat.com>; sean.hefty@intel.com <sean.hefty@intel.com>; hal.rosenstock@gmail.com <hal.rosenstock@gmail.com>; Rohit Sajan Kumar <rohit.sajan.kumar@oracle.com>; Manjunath Patil <manjunath.b.patil@oracle.com>; Rama Nichanamatlu <rama.nichanamatlu@oracle.com>
>> Cc: linux-rdma@vger.kernel.org <linux-rdma@vger.kernel.org>; linux-kernel@vger.kernel.org <linux-kernel@vger.kernel.org>
>> Subject: [PATCH] net/mlx5: Add sysfs entry for vhca to /sys/class/infiniband/mlx5
>>
>> While collecting diagnostic information (Ex:wqdump) in virtual
>> environment, we need vhca id to collect data belonging a particular VF.
>> This patch adds a sysfs entry to show the vhca id inside guest.
>>
>> Signed-off-by: Rohit Nair <rohit.sajan.kumar@oracle.com>
>> ---
>>  drivers/infiniband/hw/mlx5/main.c | 12 ++++++++++++
>>  1 file changed, 12 insertions(+)
>>
>> diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
>> index 32a0ea8..dd935bc 100644
>> --- a/drivers/infiniband/hw/mlx5/main.c
>> +++ b/drivers/infiniband/hw/mlx5/main.c
>> @@ -2499,12 +2499,24 @@ static ssize_t board_id_show(struct device *device,
>>  }
>>  static DEVICE_ATTR_RO(board_id);
>>
>> +static ssize_t vhca_id_show(struct device *device,
>> +                           struct device_attribute *attr, char *buf)
>> +{
>> +       struct mlx5_ib_dev *dev =
>> +               container_of(device, struct mlx5_ib_dev, ib_dev.dev);
>> +       return sysfs_emit(buf, "%d [0x%x]\n",
>> +                      MLX5_CAP_GEN(dev->mdev, vhca_id),
>> +                      MLX5_CAP_GEN(dev->mdev, vhca_id));
>> +}
>> +static DEVICE_ATTR_RO(vhca_id);
>> +
>>  static struct attribute *mlx5_class_attributes[] = {
>>          &dev_attr_hw_rev.attr,
>>          &dev_attr_hca_type.attr,
>>          &dev_attr_board_id.attr,
>>          &dev_attr_fw_pages.attr,
>>          &dev_attr_reg_pages.attr,
>> +       &dev_attr_vhca_id.attr,
>>          NULL,
>>  };
>>
>> --
>> 1.8.3.1
>>

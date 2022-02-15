Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F02E4B6EE7
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Feb 2022 15:33:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbiBOObj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 15 Feb 2022 09:31:39 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234156AbiBOObi (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 15 Feb 2022 09:31:38 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2063.outbound.protection.outlook.com [40.107.94.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E93312DC5
        for <linux-rdma@vger.kernel.org>; Tue, 15 Feb 2022 06:31:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JqRq66iYD6Ax4lynQA5nlijJnRDHNG5QG3CPWavNHR9hShI4loNF3SKI3kGTxHe2uV6kxvntvFGdPOhEe8HU3NtW2XL5gvNITxhmwPyrosAXj8oaRbok3X86lc1SH8u7RdVmuyGP46bnToOGc0JRYAz6uY/T8wnXpwwXGFyRLjuY7MM7TU/xL1ua5PxA+8mMC1rnIIkhxPjH/sMg7Qxe/CHHtC4Nu2MrLQv1H+Vlu+C6O/YIw3o2hqWlqJjZGZokda45YEBtGB8RjfQ7b9HE2Gv9z0hilhybowoaUH39Zr1blmAzRYZRtwL9EGp4EkCr4HXNKt9UCKdzmkbb/pAMEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ljgmYLxPH69ZduiLO8RDBmZTZ5aFmeIyyqIQTKnYilk=;
 b=IB8LXL0iDJbT05vbMZYXxhLF1v+bkFvFCbtc3ZqYd2hF1M4YoD069oMPiHyTUvrlCF5eM0JSrTK2p+2H32raCsLUzQ8p1xZFg6iivcKtQ2+GKnWRS3BIadiL9RELQLVHoBbqSza+SU5+umD6lTcFzldKsiZLAt5zJzQHAQpWV8Xaji1vLRxqur+bXf/vspWB36yWBfsv4+0clZ4Wmf6V5U964a7z/ujmvYnIebAezIT4oV7lxSHOiK897UtSFzSiPoCYWiBONJ6lr0x5j/Pjdihpx5ZYBYWtOgt8oN0rFKL4Tmk4bgpTKAlKjB+kTqSbOVt6ue8Jv/OzOAcP4Sb/RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ljgmYLxPH69ZduiLO8RDBmZTZ5aFmeIyyqIQTKnYilk=;
 b=dy4A5cgoWAudFydJ7QcCqN06YS+mEn9kPbogBbFuyRDaCaUBLF8z9vB4Y3IOWHw67gUzhe18ve9NI5TpeWuaslHlKsMwoeYsYjRplICsUOw2T3JSY0x7921hBPhrWWDVZ4BtLYKN/zTHf0e54Gp0jvNXJQNvsv9+NnWA2TfrBqmR6hK1Sa2qXemfHudVpt34dDZvciyTEg594ogSZVP6VC4dYUKVTJO+y1abr/vcZheGmZe8uYcK9YVN6k7lgNxoTL38wT16/GqCtjdkeCji9ObJ7gffoF6wZWAybLR7lmYLqchv92xAfumezmYRIX3gzTzV+jzxZem9mc1IAjx1Sw==
Received: from MWHPR17CA0076.namprd17.prod.outlook.com (2603:10b6:300:c2::14)
 by BN8PR12MB3441.namprd12.prod.outlook.com (2603:10b6:408:49::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Tue, 15 Feb
 2022 14:31:24 +0000
Received: from CO1NAM11FT027.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:c2:cafe::2d) by MWHPR17CA0076.outlook.office365.com
 (2603:10b6:300:c2::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11 via Frontend
 Transport; Tue, 15 Feb 2022 14:31:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.235) by
 CO1NAM11FT027.mail.protection.outlook.com (10.13.174.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4975.11 via Frontend Transport; Tue, 15 Feb 2022 14:31:24 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 15 Feb
 2022 14:31:01 +0000
Received: from [172.27.0.132] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Tue, 15 Feb 2022
 06:30:58 -0800
Content-Type: multipart/mixed;
        boundary="------------IT8PUkgEppKmm0o80S9HTPbm"
Message-ID: <fe9842f1-e5c7-7569-426e-9029662bb4f3@nvidia.com>
Date:   Tue, 15 Feb 2022 16:30:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [bug report] NVMe/IB: reset_controller need more than 1min
Content-Language: en-US
To:     Yi Zhang <yi.zhang@redhat.com>
CC:     Sagi Grimberg <sagi@grimberg.me>,
        Haakon Bugge <haakon.bugge@oracle.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
        OFED mailing list <linux-rdma@vger.kernel.org>
References: <CAHj4cs8cT23z+h2i+g6o3OQqEhWnHS88JO4jNoQo0Nww-sdkYg@mail.gmail.com>
 <CAHj4cs9EazUmtbjPKp5TXO4kRPcSShiYbhmsHwfh7SOTQAeoyw@mail.gmail.com>
 <c6d43a10-44bc-e73a-8836-d75367df049b@grimberg.me>
 <162ec7c5-9483-3f53-bd1c-502ff5ac9f87@nvidia.com>
 <CAHj4cs_kCorBjHcvamhZLBNXP2zWE0n_e-3wLwb-ERfpJWJxUA@mail.gmail.com>
 <3292547e-2453-0320-c2e7-e17dbc20bbdd@nvidia.com>
 <CAHj4cs9QuANriWeLrhDvkahnNzHp-4WNFoxtWi2qGH9V0L3+Rw@mail.gmail.com>
 <fcad6dac-6d40-98d7-93e2-bfa307e8e101@nvidia.com>
 <CAHj4cs_WGP9q10d9GSzKQZi3uZCF+S8qW1sirWZWkkHuepgYgQ@mail.gmail.com>
 <2D31D2FB-BC4B-476A-9717-C02E84542DFA@oracle.com>
 <CAHj4cs-yt1+Lufqgwira-YbB6PHtJ=2JA_Vora_CfarzSzoFrA@mail.gmail.com>
 <4BB6D957-6C18-4E58-A622-0880007ECD9F@oracle.com>
 <CAHj4cs_ta5WR7j0qvHyr1tSCR-U7=svY5j8Hctd7YUMNcGXsaA@mail.gmail.com>
 <a2fabeb3-5f19-11b6-8c00-a479e3759182@grimberg.me>
 <bdb675e4-1de8-400b-9d43-9f0c18147dc4@nvidia.com>
 <CAHj4cs_C=pCz41hg1AnQcEZPBRK78WTUq8HE3n_28t56iN1FuA@mail.gmail.com>
From:   Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <CAHj4cs_C=pCz41hg1AnQcEZPBRK78WTUq8HE3n_28t56iN1FuA@mail.gmail.com>
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 60c8bbae-e766-4fba-c208-08d9f08fd7d8
X-MS-TrafficTypeDiagnostic: BN8PR12MB3441:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB344102AC548281C07C40CEC7DE349@BN8PR12MB3441.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WghMe73qeVyUWypuIGGDALcwNJADdcEUUU8ETwYkN7X+zrCqC2mG9mRQ5wkjePIai2/vEh7xXpuzeJ35PitpmFgOqF3d/2Xb3uzl74MuD/UTfgWm7TURW/e1wuypkU/xr61VNoRSq0svc2zcECGY8JeZR596wIwsylPI9+5t3uKclNPuCnOfZD3KTniar1vvmBA1XEHLBXCxd2bqISLr+7U/NPx6qB0mHCBiES+nKvJBOdry7Sky2wF93cIo9heXYVfZi5E3J3X84AnRkrdrXpNE0xcD38As3KKJMv+/ePmmbEwpPyuqVGoVut+ylG/OcYr5Isvt+6dKqtsdo58SHEwrvAMrks0kH2A53Oo5yWm2lC6Oz5PdzgEbZG1lyxtE+7k8nWNeDzqMMXeW095RNbB5DkmRhohq0qCl40ucZ71uOrHxd6ZTq96HpkHujZQfSel8XLwbXl4X8KwLUWEnutTG4NV0FUWUk3Dm4XLuxzUzxLvThrjtsG2Go096PsSzUd8ludl7Zvqc4+9WD4Guwzj8/iT7qVRjDnk6BXK2dyoT43SDe/e9bV1dPw4PJiGuie5C3qxUNe5BDmGg5e8wpptUTdndYAkqa+AnrZUeroCD59H+clw2eax8NN0I4WNC5Tx/rmDlQkVnQc5QWEvpHKjD6IuijWNMnLC0kNPXCSDiQFWk4SqmqqzmyqCOXt2ItClW67UYlZuXjPiCj7tDqU4sweHFBA37qeAU3cluBty74o3g636BlgXoJcJR6pb2
X-Forefront-Antispam-Report: CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(83380400001)(16576012)(508600001)(82310400004)(4326008)(8676002)(70206006)(53546011)(70586007)(316002)(6666004)(33964004)(31696002)(2616005)(86362001)(336012)(426003)(6916009)(54906003)(8936002)(186003)(26005)(31686004)(356005)(81166007)(235185007)(40460700003)(36756003)(47076005)(16526019)(2906002)(36860700001)(5660300002)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2022 14:31:24.0838
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 60c8bbae-e766-4fba-c208-08d9f08fd7d8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT027.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3441
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

--------------IT8PUkgEppKmm0o80S9HTPbm
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit

Thanks Yi Zhang.

Few years ago I've sent some patches that were supposed to fix the KA 
mechanism but eventually they weren't accepted.

I haven't tested it since but maybe you can run some tests with it.

The attached patches are partial and include only rdma transport for 
your testing.

If it work for you we can work on it again and argue for correctness.

Please don't use the workaround we suggested earlier with these patches.

-Max.

On 2/15/2022 3:52 PM, Yi Zhang wrote:
> Hi Sagi/Max
>
> Changing the value to 10 or 15 fixed the timeout issue.
> And the reset operation still needs more than 12s on my environment, I
> also tried disabling the pi_enable, the reset operation will be back
> to 3s, so seems the added 9s was due to the PI enabled code path.
>
> On Mon, Feb 14, 2022 at 8:12 PM Max Gurtovoy <mgurtovoy@nvidia.com> wrote:
>>
>> On 2/14/2022 1:32 PM, Sagi Grimberg wrote:
>>>> Hi Sagi/Max
>>>> Here are more findings with the bisect:
>>>>
>>>> The time for reset operation changed from 3s[1] to 12s[2] after
>>>> commit[3], and after commit[4], the reset operation timeout at the
>>>> second reset[5], let me know if you need any testing for it, thanks.
>>> Does this at least eliminate the timeout?
>>> --
>>> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
>>> index a162f6c6da6e..60e415078893 100644
>>> --- a/drivers/nvme/host/nvme.h
>>> +++ b/drivers/nvme/host/nvme.h
>>> @@ -25,7 +25,7 @@ extern unsigned int nvme_io_timeout;
>>>   extern unsigned int admin_timeout;
>>>   #define NVME_ADMIN_TIMEOUT     (admin_timeout * HZ)
>>>
>>> -#define NVME_DEFAULT_KATO      5
>>> +#define NVME_DEFAULT_KATO      10
>>>
>>>   #ifdef CONFIG_ARCH_NO_SG_CHAIN
>>>   #define  NVME_INLINE_SG_CNT  0
>>> --
>>>
>> or for the initial test you can use --keep-alive-tmo=<10 or 15> flag in
>> the connect command
>>
>>>> [1]
>>>> # time nvme reset /dev/nvme0
>>>>
>>>> real 0m3.049s
>>>> user 0m0.000s
>>>> sys 0m0.006s
>>>> [2]
>>>> # time nvme reset /dev/nvme0
>>>>
>>>> real 0m12.498s
>>>> user 0m0.000s
>>>> sys 0m0.006s
>>>> [3]
>>>> commit 5ec5d3bddc6b912b7de9e3eb6c1f2397faeca2bc (HEAD)
>>>> Author: Max Gurtovoy <maxg@mellanox.com>
>>>> Date:   Tue May 19 17:05:56 2020 +0300
>>>>
>>>>       nvme-rdma: add metadata/T10-PI support
>>>>
>>>> [4]
>>>> commit a70b81bd4d9d2d6c05cfe6ef2a10bccc2e04357a (HEAD)
>>>> Author: Hannes Reinecke <hare@suse.de>
>>>> Date:   Fri Apr 16 13:46:20 2021 +0200
>>>>
>>>>       nvme: sanitize KATO setting-
>>> This change effectively changed the keep-alive timeout
>>> from 15 to 5 and modified the host to send keepalives every
>>> 2.5 seconds instead of 5.
>>>
>>> I guess that in combination that now it takes longer to
>>> create and delete rdma resources (either qps or mrs)
>>> it starts to timeout in setups where there are a lot of
>>> queues.
>
--------------IT8PUkgEppKmm0o80S9HTPbm
Content-Type: text/plain; charset="UTF-8";
	name="0001-Revert-nvme-unexport-nvme_start_keep_alive.patch"
Content-Disposition: attachment;
	filename="0001-Revert-nvme-unexport-nvme_start_keep_alive.patch"
Content-Transfer-Encoding: base64

RnJvbSA0ZjU2Mjk3ODZjZWFhNjkxMmQ1YzU4NWMxOGNjNWQ4M2ZhMzQ2ZWE5IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBNYXggR3VydG92b3kgPG1ndXJ0b3ZveUBudmlkaWEu
Y29tPgpEYXRlOiBUdWUsIDEwIEFwciAyMDE4IDE1OjIxOjI5ICswMDAwClN1YmplY3Q6IFtQ
QVRDSCAxLzNdIFJldmVydCAibnZtZTogdW5leHBvcnQgbnZtZV9zdGFydF9rZWVwX2FsaXZl
IgoKVGhpcyByZXZlcnRzIGNvbW1pdCBjODc5OWVlZTM5ZTc1MjNlNWUwYmUxMGY4OTUwYjEx
Y2I2NjA4NWJkLgoKbnZtZV9zdGFydF9rZWVwX2FsaXZlKCkgd2lsbCBiZSB1c2VkIGJ5IHRo
ZSB0cmFuc3BvcnQgZHJpdmVycwp0byBmaXgga2VlcC1hbGl2ZSBzeW5jaHJvbml6YXRpb24g
YmV0d2VlbiBOVk1lLW9GIHRhcmdldC9ob3N0LgoKU2lnbmVkLW9mZi1ieTogTWF4IEd1cnRv
dm95IDxtZ3VydG92b3lAbnZpZGlhLmNvbT4KLS0tCiBkcml2ZXJzL252bWUvaG9zdC9jb3Jl
LmMgfCAzICsrLQogZHJpdmVycy9udm1lL2hvc3QvbnZtZS5oIHwgMSArCiAyIGZpbGVzIGNo
YW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvbnZtZS9ob3N0L2NvcmUuYyBiL2RyaXZlcnMvbnZtZS9ob3N0L2NvcmUuYwppbmRl
eCA5NjFhNWY4YTQ0ZDIuLjQ2ZjJkODVkNGYzMSAxMDA2NDQKLS0tIGEvZHJpdmVycy9udm1l
L2hvc3QvY29yZS5jCisrKyBiL2RyaXZlcnMvbnZtZS9ob3N0L2NvcmUuYwpAQCAtMTI4NCwx
MyArMTI4NCwxNCBAQCBzdGF0aWMgdm9pZCBudm1lX2tlZXBfYWxpdmVfd29yayhzdHJ1Y3Qg
d29ya19zdHJ1Y3QgKndvcmspCiAJYmxrX2V4ZWN1dGVfcnFfbm93YWl0KHJxLCBmYWxzZSwg
bnZtZV9rZWVwX2FsaXZlX2VuZF9pbyk7CiB9CiAKLXN0YXRpYyB2b2lkIG52bWVfc3RhcnRf
a2VlcF9hbGl2ZShzdHJ1Y3QgbnZtZV9jdHJsICpjdHJsKQordm9pZCBudm1lX3N0YXJ0X2tl
ZXBfYWxpdmUoc3RydWN0IG52bWVfY3RybCAqY3RybCkKIHsKIAlpZiAodW5saWtlbHkoY3Ry
bC0+a2F0byA9PSAwKSkKIAkJcmV0dXJuOwogCiAJbnZtZV9xdWV1ZV9rZWVwX2FsaXZlX3dv
cmsoY3RybCk7CiB9CitFWFBPUlRfU1lNQk9MX0dQTChudm1lX3N0YXJ0X2tlZXBfYWxpdmUp
OwogCiB2b2lkIG52bWVfc3RvcF9rZWVwX2FsaXZlKHN0cnVjdCBudm1lX2N0cmwgKmN0cmwp
CiB7CmRpZmYgLS1naXQgYS9kcml2ZXJzL252bWUvaG9zdC9udm1lLmggYi9kcml2ZXJzL252
bWUvaG9zdC9udm1lLmgKaW5kZXggYTE2MmY2YzZkYTZlLi4xNjEwZWM3NjRiZmMgMTAwNjQ0
Ci0tLSBhL2RyaXZlcnMvbnZtZS9ob3N0L252bWUuaAorKysgYi9kcml2ZXJzL252bWUvaG9z
dC9udm1lLmgKQEAgLTcyOSw2ICs3MjksNyBAQCBpbnQgbnZtZV9nZXRfZmVhdHVyZXMoc3Ry
dWN0IG52bWVfY3RybCAqZGV2LCB1bnNpZ25lZCBpbnQgZmlkLAogCQkgICAgICB1bnNpZ25l
ZCBpbnQgZHdvcmQxMSwgdm9pZCAqYnVmZmVyLCBzaXplX3QgYnVmbGVuLAogCQkgICAgICB1
MzIgKnJlc3VsdCk7CiBpbnQgbnZtZV9zZXRfcXVldWVfY291bnQoc3RydWN0IG52bWVfY3Ry
bCAqY3RybCwgaW50ICpjb3VudCk7Cit2b2lkIG52bWVfc3RhcnRfa2VlcF9hbGl2ZShzdHJ1
Y3QgbnZtZV9jdHJsICpjdHJsKTsKIHZvaWQgbnZtZV9zdG9wX2tlZXBfYWxpdmUoc3RydWN0
IG52bWVfY3RybCAqY3RybCk7CiBpbnQgbnZtZV9yZXNldF9jdHJsKHN0cnVjdCBudm1lX2N0
cmwgKmN0cmwpOwogaW50IG52bWVfcmVzZXRfY3RybF9zeW5jKHN0cnVjdCBudm1lX2N0cmwg
KmN0cmwpOwotLSAKMi4xOC4xCgo=
--------------IT8PUkgEppKmm0o80S9HTPbm
Content-Type: text/plain; charset="UTF-8";
	name="0002-nvme-remove-association-between-ctrl-and-keep-alive.patch"
Content-Disposition: attachment;
	filename*0="0002-nvme-remove-association-between-ctrl-and-keep-alive.pat";
	filename*1="ch"
Content-Transfer-Encoding: base64

RnJvbSBjYmQyZTIxYmM0NDg3ZTM0NWQzN2FhNjQzNDA0ZWFiNDk1YzA1ZTI1IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBNYXggR3VydG92b3kgPG1ndXJ0b3ZveUBudmlkaWEu
Y29tPgpEYXRlOiBUdWUsIDEwIEFwciAyMDE4IDE2OjMwOjE4ICswMDAwClN1YmplY3Q6IFtQ
QVRDSCAyLzNdIG52bWU6IHJlbW92ZSBhc3NvY2lhdGlvbiBiZXR3ZWVuIGN0cmwgYW5kIGtl
ZXAtYWxpdmUKCktlZXAtYWxpdmUgbWVjaGFuaXNtIGlzIGFuIGFkbWluIHF1ZXVlIHByb3Bl
cnR5IGFuZApzaG91bGQgYmUgYWN0aXZhdGVkL2RlYWN0aXZhdGVkIGR1cmluZyBhZG1pbiBx
dWV1ZQpjcmVhdGlvbi9kZXN0cnVjdGlvbi4KClNpZ25lZC1vZmYtYnk6IE1heCBHdXJ0b3Zv
eSA8bWd1cnRvdm95QG52aWRpYS5jb20+Ci0tLQogZHJpdmVycy9udm1lL2hvc3QvY29yZS5j
IHwgMyAtLS0KIDEgZmlsZSBjaGFuZ2VkLCAzIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBh
L2RyaXZlcnMvbnZtZS9ob3N0L2NvcmUuYyBiL2RyaXZlcnMvbnZtZS9ob3N0L2NvcmUuYwpp
bmRleCA0NmYyZDg1ZDRmMzEuLjM0YjAwNmE3NzI3MCAxMDA2NDQKLS0tIGEvZHJpdmVycy9u
dm1lL2hvc3QvY29yZS5jCisrKyBiL2RyaXZlcnMvbnZtZS9ob3N0L2NvcmUuYwpAQCAtNDM4
OSw3ICs0Mzg5LDYgQEAgRVhQT1JUX1NZTUJPTF9HUEwobnZtZV9jb21wbGV0ZV9hc3luY19l
dmVudCk7CiB2b2lkIG52bWVfc3RvcF9jdHJsKHN0cnVjdCBudm1lX2N0cmwgKmN0cmwpCiB7
CiAJbnZtZV9tcGF0aF9zdG9wKGN0cmwpOwotCW52bWVfc3RvcF9rZWVwX2FsaXZlKGN0cmwp
OwogCW52bWVfc3RvcF9mYWlsZmFzdF93b3JrKGN0cmwpOwogCWZsdXNoX3dvcmsoJmN0cmwt
PmFzeW5jX2V2ZW50X3dvcmspOwogCWNhbmNlbF93b3JrX3N5bmMoJmN0cmwtPmZ3X2FjdF93
b3JrKTsKQEAgLTQzOTgsOCArNDM5Nyw2IEBAIEVYUE9SVF9TWU1CT0xfR1BMKG52bWVfc3Rv
cF9jdHJsKTsKIAogdm9pZCBudm1lX3N0YXJ0X2N0cmwoc3RydWN0IG52bWVfY3RybCAqY3Ry
bCkKIHsKLQludm1lX3N0YXJ0X2tlZXBfYWxpdmUoY3RybCk7Ci0KIAludm1lX2VuYWJsZV9h
ZW4oY3RybCk7CiAKIAlpZiAoY3RybC0+cXVldWVfY291bnQgPiAxKSB7Ci0tIAoyLjE4LjEK
Cg==
--------------IT8PUkgEppKmm0o80S9HTPbm
Content-Type: text/plain; charset="UTF-8";
	name="0003-nvme-rdma-add-keep-alive-mechanism-as-admin_q-proper.patch"
Content-Disposition: attachment;
	filename*0="0003-nvme-rdma-add-keep-alive-mechanism-as-admin_q-proper.pa";
	filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSAzYTQwNzk1ZTFjNDdhYWU4Mjk3YTFkY2FhODIxZjYzZmVhNWU0YmFhIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBNYXggR3VydG92b3kgPG1ndXJ0b3ZveUBudmlkaWEu
Y29tPgpEYXRlOiBUdWUsIDEwIEFwciAyMDE4IDE2OjMzOjA2ICswMDAwClN1YmplY3Q6IFtQ
QVRDSCAzLzNdIG52bWUtcmRtYTogYWRkIGtlZXAtYWxpdmUgbWVjaGFuaXNtIGFzIGFkbWlu
X3EgcHJvcGVydHkKCkFjdGl2YXRlL2RlYWN0aXZhdGUgaXQgZHVyaW5nIGFkbWluIHF1ZXVl
IGNyZWF0aW9uL2Rlc3RydWN0aW9uCmFuZCByZW1vdmUgYXNzb2NpYXRpb24gdG8gbnZtZSBj
dHJsLgoKU2lnbmVkLW9mZi1ieTogTWF4IEd1cnRvdm95IDxtZ3VydG92b3lAbnZpZGlhLmNv
bT4KLS0tCiBkcml2ZXJzL252bWUvaG9zdC9yZG1hLmMgfCA0ICsrKy0KIDEgZmlsZSBjaGFu
Z2VkLCAzIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9kcml2
ZXJzL252bWUvaG9zdC9yZG1hLmMgYi9kcml2ZXJzL252bWUvaG9zdC9yZG1hLmMKaW5kZXgg
OTkzZTNhMDc2YTQxLi5hYjcxZjdkM2Q2YTUgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvbnZtZS9o
b3N0L3JkbWEuYworKysgYi9kcml2ZXJzL252bWUvaG9zdC9yZG1hLmMKQEAgLTkyNSw2ICs5
MjUsOCBAQCBzdGF0aWMgaW50IG52bWVfcmRtYV9jb25maWd1cmVfYWRtaW5fcXVldWUoc3Ry
dWN0IG52bWVfcmRtYV9jdHJsICpjdHJsLAogCWlmIChlcnJvcikKIAkJZ290byBvdXRfcXVp
ZXNjZV9xdWV1ZTsKIAorCW52bWVfc3RhcnRfa2VlcF9hbGl2ZSgmY3RybC0+Y3RybCk7CisK
IAlyZXR1cm4gMDsKIAogb3V0X3F1aWVzY2VfcXVldWU6CkBAIC0xMDI2LDYgKzEwMjgsNyBA
QCBzdGF0aWMgaW50IG52bWVfcmRtYV9jb25maWd1cmVfaW9fcXVldWVzKHN0cnVjdCBudm1l
X3JkbWFfY3RybCAqY3RybCwgYm9vbCBuZXcpCiBzdGF0aWMgdm9pZCBudm1lX3JkbWFfdGVh
cmRvd25fYWRtaW5fcXVldWUoc3RydWN0IG52bWVfcmRtYV9jdHJsICpjdHJsLAogCQlib29s
IHJlbW92ZSkKIHsKKwludm1lX3N0b3Bfa2VlcF9hbGl2ZSgmY3RybC0+Y3RybCk7CiAJbnZt
ZV9zdG9wX2FkbWluX3F1ZXVlKCZjdHJsLT5jdHJsKTsKIAlibGtfc3luY19xdWV1ZShjdHJs
LT5jdHJsLmFkbWluX3EpOwogCW52bWVfcmRtYV9zdG9wX3F1ZXVlKCZjdHJsLT5xdWV1ZXNb
MF0pOwpAQCAtMTE5OSw3ICsxMjAyLDYgQEAgc3RhdGljIHZvaWQgbnZtZV9yZG1hX2Vycm9y
X3JlY292ZXJ5X3dvcmsoc3RydWN0IHdvcmtfc3RydWN0ICp3b3JrKQogCXN0cnVjdCBudm1l
X3JkbWFfY3RybCAqY3RybCA9IGNvbnRhaW5lcl9vZih3b3JrLAogCQkJc3RydWN0IG52bWVf
cmRtYV9jdHJsLCBlcnJfd29yayk7CiAKLQludm1lX3N0b3Bfa2VlcF9hbGl2ZSgmY3RybC0+
Y3RybCk7CiAJZmx1c2hfd29yaygmY3RybC0+Y3RybC5hc3luY19ldmVudF93b3JrKTsKIAlu
dm1lX3JkbWFfdGVhcmRvd25faW9fcXVldWVzKGN0cmwsIGZhbHNlKTsKIAludm1lX3N0YXJ0
X3F1ZXVlcygmY3RybC0+Y3RybCk7Ci0tIAoyLjE4LjEKCg==

--------------IT8PUkgEppKmm0o80S9HTPbm--

Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB1C4403D3E
	for <lists+linux-rdma@lfdr.de>; Wed,  8 Sep 2021 18:03:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344229AbhIHQEj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 8 Sep 2021 12:04:39 -0400
Received: from mail-bn8nam11on2057.outbound.protection.outlook.com ([40.107.236.57]:57336
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235422AbhIHQEh (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 8 Sep 2021 12:04:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JMksECXxLgcGAVxNAeRky+Z5kOW9vRTP2xJlz3Inrpd3s7ahViAfhY4VSkpO1DyUVrUSHicMIJeDAVYXpDJ7JVZzdpRu3Qqr1lMSk9J0b/DS0GxG/mtdD1WbrZdRlPw98vTQMEfGL07d7Dkb/QmU1Q9sU8AyI1kjBddGARE4ozNtXbhZ4wu2mA/GrPXv/lMIJ6ERJ9K+sironB7OgRtCUWrt3oj5DBQXo4QbgT+N2Lsc2VZoruTwwfpvJM76/66kHeiEsAspj+CfhZWxx6uwHWjIG6Lw7grJSuwWqwT3No5PHA7C3+r4MvfVeVrmV0bx4LskHfgAYw/QD7waW5ywUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ly9OuoJhYEzfUv8QJKaBcccxR9Gn2ypzKDRS8fJkDbE=;
 b=dhxalp93eAgsqbu+TBj3DG8XRhW/1544CVdRoY1W6iArkEU4PphjXmFU1szfy2Ia37NYZrlLdHmsABoZ66VXWl1TlkDAh257qApwq9Iwxp1RpxAFsAIVAlLouGA2H97dRY4pm8wAt30Na4nw6Hu9xwzsuD6J/MMSiBUejXEjOVtA56thGaq9+iGiRMMkSF2v8NGguDCwioXEXH+qBevfjjDkNWOzSDbqJsu4tE7uvVOFwgH+oqjfGS4nYDyYfaKXQZ/fi2qHwbXy9oV4QqUsyvKz9KyVUCCzKRjQjhRO9ED7rUhghzE+97K6aJShIv0XoKNz+ArqVubTAZz9DAdNQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ly9OuoJhYEzfUv8QJKaBcccxR9Gn2ypzKDRS8fJkDbE=;
 b=ibFCJNRz3b0kQxyJ6cEDb1bfNzYXgeBo9QQ7+wUih8yppvdI20pgWqZ1DjgJ4OwooxMkc9EkKmPkmXIKfCZWPBkDUu0mR0X7VVed6ekS5vq6fcNiLDkFnbH7ytkSnGQ8T5RywgiRTXVlOd4+m12THdalNc0cNojKzKopse2ySXI=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5129.namprd12.prod.outlook.com (2603:10b6:408:136::12)
 by BN9PR12MB5355.namprd12.prod.outlook.com (2603:10b6:408:104::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.16; Wed, 8 Sep
 2021 16:03:28 +0000
Received: from BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::94bc:6146:87a:9f3c]) by BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::94bc:6146:87a:9f3c%5]) with mapi id 15.20.4478.025; Wed, 8 Sep 2021
 16:03:28 +0000
Subject: Re: crash observed with pci_enable_atomic_ops_to_root on VF devices.
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
Cc:     linux-pci@vger.kernel.org, linux-rdma@vger.kernel.org,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>,
        Andrew Gospodarek <andrew.gospodarek@broadcom.com>,
        Michael Chan <michael.chan@broadcom.com>,
        Devesh Sharma <devesh.sharma@broadcom.com>,
        Jay Cornwall <Jay.Cornwall@amd.com>
References: <20210908155145.GA867184@bjorn-Precision-5520>
From:   Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <978872c2-f2c7-dcc3-14d5-799755cf0726@amd.com>
Date:   Wed, 8 Sep 2021 12:03:23 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20210908155145.GA867184@bjorn-Precision-5520>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: YTOPR0101CA0068.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::45) To BN9PR12MB5129.namprd12.prod.outlook.com
 (2603:10b6:408:136::12)
MIME-Version: 1.0
Received: from [192.168.2.100] (142.186.47.3) by YTOPR0101CA0068.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:14::45) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend Transport; Wed, 8 Sep 2021 16:03:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a08f1165-652d-4d75-1e0b-08d972e23187
X-MS-TrafficTypeDiagnostic: BN9PR12MB5355:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN9PR12MB535544ED7CEA68BBC72AD32C92D49@BN9PR12MB5355.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QxPAomiqCnfMQ+cIejjBYhJRNSNwrNmRJ0PMUBEodSyKKr5S4CEhvKI84VVwGsI1Z+E1b2ASCs6kzmYHJS0r5+PGrxgJIf2a3D0Ih7GkOSJ2XyGHh82i+meqEPt24blVokiBYNyNR5grLUF0X1jjMBjG4OdwRnGiU1FelAq3o+Xb22+if/IGDkhZEVhkVeCR2XXlcQNxc3xF2tlkYM2gcucve0/7fyetjS8swDMlzdvFpbrhHsZ8I+gGPtfx4CF6lz1r9S9EMlUTsNhjD9JQM+/kzyZv7KvT1OZI/JpYI99UD7/Ga8OrgfLjheC2OxSd8tARotZ0rTvDvkUhkg37SxFJvw5LmjSCMcbDi+9q/eXy7oJIFpC6gSW2eDkEl3EMVWYM/ycdQHyUi3A97eu8GNH+uzd68kyJmnlid+3/Da81WjFOcvjQsi9jN6tz3LIQ+lO+j8PxOSycatn3PhBq4XfgDXZddGTSjTNlplJtKjPdIEYn7WNATveIq1lyS0zkY3G5ClYFWgt7Mnma6pqlGIvb+t5YeXo9L85lIexxltAFdZX+2YuV9wITNfp3odI/NpZpc1+WykBcxupxoA3ziIcjGXCWxZQEgVr6m9f7MwFKsxNEiNxqpq6H53+vcHyepllELVKUdRMbveQXH2jAry+/Ny2DTiLyyMR8mT+2gg7v7YM6crgXZsXVg/p6avUtkZE3fsnxx0+GgL9Z0mfckWVlCpkmm5qmjci99RLsdKef2g8/VOVVQZTbhV+9oo3b5m47bg/cwe8NYe7pM4fye1FbgXmIObbLWehpzkCgeEPNGKcpaunaOD0I417rhde9EUy/yPSA2l+oTo1EsbwZb26LWbPOWFO5IhOuh/v9nhI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5129.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(346002)(396003)(376002)(39860400002)(38100700002)(2906002)(186003)(8676002)(2616005)(8936002)(86362001)(110136005)(6636002)(66476007)(6486002)(66556008)(956004)(26005)(44832011)(478600001)(966005)(31686004)(54906003)(316002)(4326008)(66946007)(83380400001)(36756003)(16576012)(31696002)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WktmMDN2cnNkMjd3MmkwaGRzenRaNVYvTHltTlc0WnVaSnNWbTdVUTEwRERl?=
 =?utf-8?B?MTg2SUsvRzBuSmpucmEyRUMyb0tRZjBEaGdwUDdPYUtHZmthVjM5TlNZREFK?=
 =?utf-8?B?VnBwb3dMUHZHdWQ5MFRuMUNTUWxNTnlvbU5RUlBMd0RGYUdwSXE0TVlqNHdt?=
 =?utf-8?B?YzhDQUo1bXJzVVFxVUZVMHhicm5hOUtYcUpaa3ZiR3FSWkh5YXhpbU0vV0Mw?=
 =?utf-8?B?MkZ2czZPaTRIdVMwcUsvWGZwUG9IZ0FiV1hOaWU5aHBSTWVNdGJhSGdVT1J1?=
 =?utf-8?B?T2xaQ3A4bzJOSk0yWUxFVThJZmFJaEFkcGJGdWhpMDhpUy9aVXJBUGcyUFpN?=
 =?utf-8?B?b2xtdVFjQWwyM3VmcGl2Z3dnMmd6WXcrYlNFWEhSTUQyRlNTT1ZwVk0vUHUv?=
 =?utf-8?B?bElTSldlR2lWOWxWNU5TTjVmN1pPNTl3WCtUOEJPdDQvSk5KK1drMjNnOExI?=
 =?utf-8?B?SVg5SlFnUGVtMVc3QlRuVG54YkFLQVBaQ0x2NE5WOTVMTUxPMW9qc2RYOUFW?=
 =?utf-8?B?TVZmTlRURGlPZFR3dHpZMU4vaVkrRWNFTzByc3lScjB1U1BESjcvN3docTlw?=
 =?utf-8?B?VEhXeXVZMTdlY3dFNmpjd0pIYzN0WTJHMW1LYy9ubDN4SUlNRURjMWpyZkZl?=
 =?utf-8?B?cWQ5dTA5eGJoZkppbTZaY2pGRDBWNG5Gb1RKMjU0MjlWVFdyekZBS1l4cmFG?=
 =?utf-8?B?Q0xBUzlDUStYSDkrNHV4STl0cE45d0ljS00vT2xtc3JSVHlmb3p4dTVqM2x0?=
 =?utf-8?B?dFZGSC9EZnVhR3JuYlAzVjJnWWYvcEM3dmNOeXhZSkdZbm5Cb3lRazdDMWVn?=
 =?utf-8?B?TGJ2cUVsMHZIc1N6QlMxQUJSYzVETU43dmY1V0d0V0l2b200NUdzVkkvdW1T?=
 =?utf-8?B?WExoOVRRNk9LNXBCWWxpOXBWZEpWWGE0UFRvaVd4SWZXeWxtcjhLSlFEQ213?=
 =?utf-8?B?WDRaYWlJeU9tTFMvY0tzVmZoeXdpdEFic0FXTk1BT0NLT3N5SVpaMWtyMERy?=
 =?utf-8?B?ZnBWcWNLZmt1d2EwSEFyb1ArcW1jcjlJdHBJSjRMLzhRUUNzalgvRVdJOFpE?=
 =?utf-8?B?bDZ0c0xwK3MwdStYZ3V2L1dtdk4xWWhPc1FydXNNSjIwU2lsU2hsSy9qV1pi?=
 =?utf-8?B?MFl3VkdoYW1HYVBrM1ZoNER2dkhFR3psbWlwVlhrZEl2SUs0WUh1Z2hpODhz?=
 =?utf-8?B?OFYydnh2N2d3czEzaGNMa09ibE4wa1c2WHp6WGViL2Fra1RYalJPSU8zaTVY?=
 =?utf-8?B?VnZLbGR1WWVnM3N2Z250NXd6SVVyY21jS3V4eStLMTBUa3h5N1RYUC9sVTM2?=
 =?utf-8?B?ZlFQZFNrSjdPalpoUlBxTnhXYm9kREFCbDBaeUFuVVhMdlljL3pOdTFWMWNB?=
 =?utf-8?B?UWVzdlhoVG9qN0xNUlkwQ3J6eVIyMXZGTWQ3MEV1SUNsV0U3eHRpaDlHZnhw?=
 =?utf-8?B?bXFKUVBCWnh4V0pkcG5zZU5IZXc5RGJiLzlMSlJob3R0WUFFdDRFN1dWMlhE?=
 =?utf-8?B?My9ENGs5R2VGbzN1UmtRQkNTMk00VWNsbklVanNzYW9aMCtvM0V1djFUaEJl?=
 =?utf-8?B?dHdmV0Y2YUl6VVVHWVEvR3pBVkZLM2tkU2xTUG1UdUZkb3REbHRISHFHbDVi?=
 =?utf-8?B?clU5cXo0L0EwdTNQTmFtMzIxT3p2NGNzeG1PSFpOc1c4ZmszQW1oOHpuM1FN?=
 =?utf-8?B?TmdiQWRpMVA3dGlhM2tvQmptcmd3YUR1VFVUdkRWamorRkJNYjBrTGluV3lB?=
 =?utf-8?Q?J6HxGLW9uEpJuiSZkLhuNCzWHe0tk90huDThbL7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a08f1165-652d-4d75-1e0b-08d972e23187
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5129.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2021 16:03:27.8735
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sbQRcijKKZ6n9eplHzoeo1DavEru1ezfxit/d1nzU6HCsKSGdM4qNMMwXJ+efPTGcA5/BesUqc47WMbCh444ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5355
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Am 2021-09-08 um 11:51 a.m. schrieb Bjorn Helgaas:
> [+cc Devesh, Jay, Felix]
>
> On Wed, Sep 01, 2021 at 06:41:50PM +0530, Selvin Xavier wrote:
>> Hi all,
>>
>> A recent patch merged to 5.14 in the Broadcom RDMA driver  to call
>> pci_enable_atomic_ops_to_root crashes the host while creating VFs. The
>> crash is seen when pci_enable_atomic_ops_to_root is called with
>> a VF pci device.  pdev->bus->self is NULL.  Is this expected for VF?
> Sorry I missed this before.  I think you're referring to 35f5ace5dea4
> ("RDMA/bnxt_re: Enable global atomic ops if platform supports") [1],
> so I cc'd Devesh (the author).
>
> It *is* expected that virtual buses added for SR-IOV have
> bus->self == NULL, but I don't think adding a check for that is
> sufficient.
>
> The AtomicOp Requester Enable bit is in the Device Control 2 register,
> and per PCIe r5.0, sec 9.3.5.10, it is reserved in VFs and the PF
> value applies to all associated VFs.
>
> pci_enable_atomic_ops_to_root() does not appear to take that into
> account, so I also cc'd Jay and Felix, the authors of 430a23689dea
> ("PCI: Add pci_enable_atomic_ops_to_root()") [2].
>
> It looks like we need to enable AtomicOps in the *PF*, not in the VF.
> Maybe that means pci_enable_atomic_ops_to_root() should return failure
> when called on a VF, and it should be up to the driver to call it on
> the PF instead?  I'm not an expert on how VFs are used, but I don't
> like the idea of device B reaching out to change the configuration
> of device A, especially when the change also affects devices C, D,
> E, ...

Interesting timing. [+Shaoyun] is just working on SR-IOV problems with
atomic operations these days.

I think it makes sense for pci_enable_atomic_ops_to_root to fail on VFs.
The guest driver either has to work without atomic ops, or it has to
rely on side-band information from the host (PF) driver to know whether
atomic ops are available.

Regards,
  Felix


>
> Bjorn
>
> [1] https://git.kernel.org/linus/35f5ace5dea4
> [2] https://git.kernel.org/linus/430a23689dea
>
>> Here is the stack trace for your reference.
>> crash> bt
>> PID: 4481   TASK: ffff89c6941b0000  CPU: 53  COMMAND: "bash"
>>  #0 [ffff9a94817136d8] machine_kexec at ffffffffb90601a4
>>  #1 [ffff9a9481713728] __crash_kexec at ffffffffb9190d5d
>>  #2 [ffff9a94817137f0] crash_kexec at ffffffffb9191c4d
>>  #3 [ffff9a9481713808] oops_end at ffffffffb9025cd6
>>  #4 [ffff9a9481713828] page_fault_oops at ffffffffb906e417
>>  #5 [ffff9a9481713888] exc_page_fault at ffffffffb9a0ad14
>>  #6 [ffff9a94817138b0] asm_exc_page_fault at ffffffffb9c00ace
>>     [exception RIP: pcie_capability_read_dword+28]
>>     RIP: ffffffffb952fd5c  RSP: ffff9a9481713960  RFLAGS: 00010246
>>     RAX: 0000000000000001  RBX: ffff89c6b1096000  RCX: 0000000000000000
>>     RDX: ffff9a9481713990  RSI: 0000000000000024  RDI: 0000000000000000
>>     RBP: 0000000000000080   R8: 0000000000000008   R9: ffff89c64341a2f8
>>     R10: 0000000000000002  R11: 0000000000000000  R12: ffff89c648bab000
>>     R13: 0000000000000000  R14: 0000000000000000  R15: ffff89c648bab0c8
>>     ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
>>  #7 [ffff9a9481713988] pci_enable_atomic_ops_to_root at ffffffffb95359a6
>>  #8 [ffff9a94817139c0] bnxt_qplib_determine_atomics at
>> ffffffffc08c1a33 [bnxt_re]
>>  #9 [ffff9a94817139d0] bnxt_re_dev_init at ffffffffc08ba2d1 [bnxt_re]
>> #10 [ffff9a9481713a78] bnxt_re_netdev_event at ffffffffc08bab8f [bnxt_re]
>> #11 [ffff9a9481713aa8] raw_notifier_call_chain at ffffffffb9102cbe
>> #12 [ffff9a9481713ad0] register_netdevice at ffffffffb9803ff3
>> #13 [ffff9a9481713b08] register_netdev at ffffffffb980410a
>> #14 [ffff9a9481713b18] bnxt_init_one at ffffffffc0349572 [bnxt_en]
>> #15 [ffff9a9481713b70] local_pci_probe at ffffffffb953b92f
>> #16 [ffff9a9481713ba0] pci_device_probe at ffffffffb953cf8f
>> #17 [ffff9a9481713be8] really_probe at ffffffffb9659619
>> #18 [ffff9a9481713c08] __driver_probe_device at ffffffffb96598fb
>> #19 [ffff9a9481713c28] driver_probe_device at ffffffffb965998f
>> #20 [ffff9a9481713c48] __device_attach_driver at ffffffffb9659cd2
>> #21 [ffff9a9481713c70] bus_for_each_drv at ffffffffb9657307
>> #22 [ffff9a9481713ca8] __device_attach at ffffffffb96593e0
>> #23 [ffff9a9481713ce8] pci_bus_add_device at ffffffffb9530b7a
>> #24 [ffff9a9481713d00] pci_iov_add_virtfn at ffffffffb955b1ca
>> #25 [ffff9a9481713d40] sriov_enable at ffffffffb955b54b
>> #26 [ffff9a9481713d90] bnxt_sriov_configure at ffffffffc034d913 [bnxt_en]
>> #27 [ffff9a9481713dd8] sriov_numvfs_store at ffffffffb955acb4
>> #28 [ffff9a9481713e10] kernfs_fop_write_iter at ffffffffb93f09ad
>> #29 [ffff9a9481713e48] new_sync_write at ffffffffb933b82c
>> #30 [ffff9a9481713ed0] vfs_write at ffffffffb933db64
>> #31 [ffff9a9481713f00] ksys_write at ffffffffb933dd99
>> #32 [ffff9a9481713f38] do_syscall_64 at ffffffffb9a07897
>> #33 [ffff9a9481713f50] entry_SYSCALL_64_after_hwframe at ffffffffb9c0007c
>>     RIP: 00007f450602f648  RSP: 00007ffe880869e8  RFLAGS: 00000246
>>     RAX: ffffffffffffffda  RBX: 0000000000000002  RCX: 00007f450602f648
>>     RDX: 0000000000000002  RSI: 0000555c566c4a60  RDI: 0000000000000001
>>     RBP: 0000555c566c4a60   R8: 000000000000000a   R9: 00007f45060c2580
>>     R10: 000000000000000a  R11: 0000000000000246  R12: 00007f45063026e0
>>     R13: 0000000000000002  R14: 00007f45062fd880  R15: 0000000000000002
>>     ORIG_RAX: 0000000000000001  CS: 0033  SS: 002b
>>
>> Please suggest a fix for solving this issue. Is adding a NULL check
>> for bus->self sounds okay?
>>
>> Thanks,
>> Selvin

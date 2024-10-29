Return-Path: <linux-rdma+bounces-5593-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11DA69B41DC
	for <lists+linux-rdma@lfdr.de>; Tue, 29 Oct 2024 06:43:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35A97283800
	for <lists+linux-rdma@lfdr.de>; Tue, 29 Oct 2024 05:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F4104200B88;
	Tue, 29 Oct 2024 05:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="FDq9B4qv"
X-Original-To: linux-rdma@vger.kernel.org
Received: from esa13.fujitsucc.c3s2.iphmx.com (esa13.fujitsucc.c3s2.iphmx.com [68.232.156.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85BEC28E7;
	Tue, 29 Oct 2024 05:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.156.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730180623; cv=fail; b=lN/YvyFPtBBwvRMDcS/E1SRPf0nq28cN1YaSXYwLviRmy24p4rmagBNu/zS5irImawEJnaH92EuVOv3XeA8flrSLEw2Nq/mDxBsx8QHuv0qIvokQT0d+NOSikG2/42CoSQ4ZZRwHNPOxaQK6M7D7YAtquDrTZXNbhnJx+qvgdhE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730180623; c=relaxed/simple;
	bh=yzoqW24ULutNJp5Wq+QIrtkjAE25mM87Ym75s9gnpxQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qsBn6QK4LH/snCFvbDWR3DEibHurJHgFZ9/cgSY15zQ+v4pJkpjA0f7HQblxqXMPXdHW6ecajRdhjSVN7G1xxM7DKCTjTYlIRur1yKtzQw8ytAqadhR9dCWUh3piAKxsf9z/qhHxoknHM+mMSOX1EqlOQ6hWINrzOk+5zLHQPmU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=FDq9B4qv; arc=fail smtp.client-ip=68.232.156.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1730180621; x=1761716621;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=yzoqW24ULutNJp5Wq+QIrtkjAE25mM87Ym75s9gnpxQ=;
  b=FDq9B4qv/kTNQD73L9EqGfK38+T0yI+cAiaKDfQsGARuwJuPik5rZUBc
   5npkWML4UKxxjtxGDVTYDG7pZKwhY469b7fsKR0QodS31RWWWFxJ6QVDo
   bvxu/+VqcC1EuSaSD7AGl3o2w3Z5qKgPRMTwdVehzKhyzdaPqtcSg8Up6
   r9GXBBfdYU7jOEk06Igblzhu8+RZDn2kzxypBlah+U0+Hhi2tZ+in8jXL
   oM3PK6t2p6IZZbgYQFS7+UPiDW35bUrZJat+3CeUVaeBcJQx+rNexBKGB
   SQf1WCqiPwnX2UDMxY8rqqANAy0CkyYm44JAcMz3rrK56ouBD+kCy+bVB
   w==;
X-CSE-ConnectionGUID: Mz4PXvN/TQerG31GMCbSGw==
X-CSE-MsgGUID: nVgD00MLQZmcMDDViQMh0Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11239"; a="134709346"
X-IronPort-AV: E=Sophos;i="6.11,241,1725289200"; 
   d="scan'208";a="134709346"
Received: from mail-japaneastazlp17011029.outbound.protection.outlook.com (HELO TYVP286CU001.outbound.protection.outlook.com) ([40.93.73.29])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2024 14:43:32 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BgOYn1/NWh5BouGGj9tMmeS3eYJRFV3a8nbXTMFZ8MnmYOpTdrO9/VJfQiEwwfL2ok+O23T14TpsmQ5932FzfxtovEqq66hDqgkcIVgN+rjmTJPfEoLG67fCxYbXJtJHZ8za9niN+e482Ljw2TbXFE34NnyIK7L4ULs8CXTKMp3S5lhOgNQKaLFDdUJFND14DY9azuw4oCt1jDPa3qH8bRyUbXIHCHzzv5lWvFGqrP0L4rfmyumwkDRdUE6y6tc7zIQ6nDXkw/0SvkJVHRT07iH009EkVpR0LH6nNvZ3wH4EprrW94mId6AHQx3EoF+qPANrAKloMiP00NIDXf5Gvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yzoqW24ULutNJp5Wq+QIrtkjAE25mM87Ym75s9gnpxQ=;
 b=vQoC97W8TD6ALL0cHXjRyL4aORL2HxInIagypazfa+F5LytuegNzH8L64i7CpJ4LV9ZxKuXj9Pnqx5ho45/IB4Y8Pucqe8p0JApmZbyENtc+RJ8n4u1PXjwbh3ZUxodQ8GPdAlgF+Yw5oPYdgSqBWe0NGKjIk/sIT7pINWkGeUkUngC9HUSeIpG4LHbniYRYAj6IN3V08wJltsVXmQWxeW3ObathO0FqXOLavyd0rZeK9uSkc66qDQe0EbMi4xH/sIkTItsJkrTaX1lOVwaC4QxSUhZlgRdg+v2koSqq6YQ/bRWiWMwHDdShtOwkfx9oYlwUtiU7P4P6uLQwI4HCdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS3PR01MB9865.jpnprd01.prod.outlook.com (2603:1096:604:1ec::9)
 by TYYPR01MB12998.jpnprd01.prod.outlook.com (2603:1096:405:1c2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.27; Tue, 29 Oct
 2024 05:43:26 +0000
Received: from OS3PR01MB9865.jpnprd01.prod.outlook.com
 ([fe80::c38:6bea:5be1:b3ff]) by OS3PR01MB9865.jpnprd01.prod.outlook.com
 ([fe80::c38:6bea:5be1:b3ff%3]) with mapi id 15.20.8093.024; Tue, 29 Oct 2024
 05:43:26 +0000
From: "Daisuke Matsuda (Fujitsu)" <matsuda-daisuke@fujitsu.com>
To: 'Jason Gunthorpe' <jgg@ziepe.ca>
CC: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"leon@kernel.org" <leon@kernel.org>, "zyjzyj2000@gmail.com"
	<zyjzyj2000@gmail.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "rpearsonhpe@gmail.com"
	<rpearsonhpe@gmail.com>, "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
Subject: RE: [PATCH for-next v8 0/6] On-Demand Paging on SoftRoCE
Thread-Topic: [PATCH for-next v8 0/6] On-Demand Paging on SoftRoCE
Thread-Index: AQHbGe7YRYuLMJ8pn0aeWjbiRhp3WLKLYXuAgBHyrnA=
Date: Tue, 29 Oct 2024 05:43:26 +0000
Message-ID:
 <OS3PR01MB9865DA0EAFDCF89DB9AB2D9AE54B2@OS3PR01MB9865.jpnprd01.prod.outlook.com>
References: <20241009015903.801987-1-matsuda-daisuke@fujitsu.com>
 <20241017192759.GC948948@ziepe.ca>
In-Reply-To: <20241017192759.GC948948@ziepe.ca>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 =?utf-8?B?TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2Uw?=
 =?utf-8?B?NTBfQWN0aW9uSWQ9N2RmYzQyZGMtNWJkYi00OTZiLWI3OTYtMDA3NmUwOWQ0?=
 =?utf-8?B?ZTJhO01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRm?=
 =?utf-8?B?ZWNlMDUwX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5?=
 =?utf-8?B?LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfRW5hYmxlZD10cnVlO01TSVBfTGFi?=
 =?utf-8?B?ZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX01ldGhv?=
 =?utf-8?B?ZD1TdGFuZGFyZDtNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRk?=
 =?utf-8?B?LTNiMGY0ZmVjZTA1MF9OYW1lPUZVSklUU1UtUkVTVFJJQ1RFROKAiztNU0lQ?=
 =?utf-8?B?X0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRkLTNiMGY0ZmVjZTA1MF9T?=
 =?utf-8?B?ZXREYXRlPTIwMjQtMTAtMjlUMDU6MzI6NThaO01TSVBfTGFiZWxfYTcyOTVj?=
 =?utf-8?B?YzEtZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX1NpdGVJZD1hMTlmMTIx?=
 =?utf-8?Q?d-81e1-4858-a9d8-736e267fd4c7;?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB9865:EE_|TYYPR01MB12998:EE_
x-ms-office365-filtering-correlation-id: c69d2414-d1c5-4e79-4fc2-08dcf7dc9c11
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|1580799027|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Y1pWVmVzS25EWFIrSkNMazFVdEpIMldsRk1vTTh6ZGVmOFNPUjBUM0xQUHYz?=
 =?utf-8?B?azhab3cvOXpMdXU5QktsSmpSSU52QjlScXJHTW5kUDJ2dVpBNnVtRitib2tH?=
 =?utf-8?B?N0VsOEllSzJoZVdOcUFJLzg5NHBsUTYxaUk5MllUVllXdSt6VldGUlExQ3V5?=
 =?utf-8?B?bEZFTVdma0Y2V0Y5eE02V01uZUdvVFRRL1dFLzRmM1FPSlJwamhFaUtxeWY3?=
 =?utf-8?B?UEZibE9uS3F6czUwazBFcUVnYmlJMzBCcU9mOHBIVUJkZmNYU1JLRGZGQjI5?=
 =?utf-8?B?M2tIREJzbDlZdzZma0lYQU0vRS9aaWhzanVNUDB1Z1VoUWlNaUZXeER5c3Fj?=
 =?utf-8?B?ei9vazZMSTRhWFJIZDlTSDA2b2s5QTJaS1ZWWXo3U2oxR3BxWnJNSGdFV1R3?=
 =?utf-8?B?aTFJZkd5elkzKzBMTC9QdzJpa0lGRHJMd09HeUVUOFg3ejJ3Q3hnM0FYSU5T?=
 =?utf-8?B?NlBPQmp5d2JxamliL1VoWlMzMk9rOTRoNE02b1d4QlIrdU93amNSK2RWaUJh?=
 =?utf-8?B?ODdzWHVtV21YWmdWVXV6eXlIZ0RHNzNRczRHdXp6Z3RvYTFkd1QzTWtaanlo?=
 =?utf-8?B?ZzRJZzg3Z1B2MHVWRmlpT0VOUXBDQUVZdXdhNmNLcUJxQXZQT1p3dWc3YWl1?=
 =?utf-8?B?akFsalhQazltSFE0MW9GQXhaWkJkOFp1MXVkd1VNTTNyTTVVVjVOWXE2K3Fu?=
 =?utf-8?B?TWRyS0NnK1ZHRUE0NFJneG1yRTRITXV2OEpGWkdRNUdKTHJhSHdxa2pFeDdj?=
 =?utf-8?B?VEZPeVJ3cXNvS0s5eVVuNEoza0RONVM0MFVVdlFRdHFkek9mclBkMlhvZzVP?=
 =?utf-8?B?dmRYV3dLanAwOHRubm9KWUxOL04yRzE1UmZlQUZMOTBDc1FBNzF3eGZFelhi?=
 =?utf-8?B?UHBWa3E4SDlwT3BsZ0FURnM2MFBmeXFXc3podloxa05BMmMvcDF1cEliMU1u?=
 =?utf-8?B?eWk2YWpkQlZWMkZPK3NiazRSUUJSRlhpcTQ0eldwc3FObDU1aG9LVGxGSlpa?=
 =?utf-8?B?OE5MaW81Ty9BRkpad3NmNVh3cDU1dmRGcjVNZ1ZhUWtHYTFQc0ZGRG1nb2pC?=
 =?utf-8?B?ZjJCajBqZzY3czF1cFRHejJsUU9FajdaeEpKeFV6OGwrek5qWHJ1UUV5YU9V?=
 =?utf-8?B?YXhsaW1LaWZBdlpldWF5T2F4ejdJMkVvQnRHNTVlMlB0WGM4SUNPRWxrTmly?=
 =?utf-8?B?bTdHcUx0b01nUjh0dmRjKzBlb0ZLa1p4eUZLYVozbkEvcEcvQVN4SkFSQVBX?=
 =?utf-8?B?b0JacVBBSzdhRE5mV3VZRXNiNWNxM0NWZzRoOGVUQjJSb1lKb2p2cGR0RkNk?=
 =?utf-8?B?NVd2N1FpVmRLdGF0WWdseEdpdCsza3FGc3FvYXB1VzlKTDZjOTJqVnpLY25G?=
 =?utf-8?B?TTBvUlFqNXNBT0RpU0I2encyZzhFQ2REZFRmM3VDUERQWU5tdWJ6Q1BzY0lv?=
 =?utf-8?B?bCthZmhHTEVjMGM2cUw0eHRDOUZoQ3pjbGhMclUxUFBDOS84TytuYkI2YWVt?=
 =?utf-8?B?dnZYNER5Tmdlbmp4aC9ZLzhkamJOd1Q3SEtYN0dveWRCdTAzZGZjMCt0ZTli?=
 =?utf-8?B?ZTBTb1dJcFdTWUhPQlQ4bEpwcWFpekNjeEwrS1F3aVY2bk9jR2hueEkybG0z?=
 =?utf-8?B?Vm5NRWwvQjFtVXN2UXozOWhwSDVaU0lva05VZ1J4OWxYSk02Yk5BSytrbW5p?=
 =?utf-8?B?b1NDVnZnM09zL2lXUzNCbkZOR2hheEIybUMwQmNEQ0ttVVdnalRyUDJPZkZo?=
 =?utf-8?B?V0Y1dENHT3JkMEMvZTdPd0YvQWlxVnlOcUYxekkyTk4xdFhKMkppcnJrWTEr?=
 =?utf-8?B?dU1BR2V1S0tscm8yaTR1SXpXb2tYNzJuQTlndVJpWUh2dTZrc3U0d2JNMUM4?=
 =?utf-8?B?bnN4Z1hUNFhlWnNsUU9QeEpwcHh1VlVNenh3VWpPMHBTNnc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB9865.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(1580799027)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VzJ0Z2x0SGorYTJVN1cwNmFNaEZFMVRTRjEvY0tnMGZXWWdVZi9JcnlCb212?=
 =?utf-8?B?NHptSk83djNxL2FMNk5qc0lJY0RqNmcrRHJPdEt3REVSZ3BVcklVMUo1dko4?=
 =?utf-8?B?dW9tQlZBQXNCTDdwVDR0Ukh6YTYrR2FoT2FZUkZJbUxrWXRFZ0NoL0tFQ2ZB?=
 =?utf-8?B?bGNHSW0zaThiTlBNTnNwcWc5QXpnTndxQWFzUVZFY0F1T1hXWEU1cWJ2U0dv?=
 =?utf-8?B?bjlScnFNa1ZDVVhVM1dqVmhoVjRNblJRTWJnRFF5TzdIOWdzNDFwM3VwRXlX?=
 =?utf-8?B?c1h5TElKZUFvemFQM040VXhSeWxpVTJRVC9ZZzQ1NWlKRFozUTBFbUh5VEE5?=
 =?utf-8?B?L205b0RXWHI5bklaUEdlQ282VXhFMUh4d2dlMm1GcCtyV2w5V3hCUiswbnRs?=
 =?utf-8?B?R2xiekc0NUxzWk9yM2xxVlVIcSsrZ1lJcHpzRzZIcndSbkxUUGRMTGJmZVZH?=
 =?utf-8?B?Q2xiWWZSa2hqa0JFc0tBZXVBNXZodDVhTTIwdFV4SnVsMDV1dEMzOVhKbzda?=
 =?utf-8?B?RWlSR2ZCSDlZOCtKV3EvbUQraCtTbnlrL1ZGSUoybHFRTzdoMWg4ejRoQmRD?=
 =?utf-8?B?elJTQkRrdTlDWmNOSXVVTUdKYkc5RGF2NTVWdGRrZ1BJeTJvOFZSdmxtcnho?=
 =?utf-8?B?RlRtY085OW1QTDdJY3haTElzSVV1MEV2WU9SY08xN2dzNHVxU010QUpZcEcr?=
 =?utf-8?B?OExYcHAvOVpIQTh3dHRxTEtmbDFpa1o1WkY1K3NXQWNXWFNZSC9tUXdvWlY4?=
 =?utf-8?B?dmJCb0JlbDBycmZZd2RuTnZGUDh6eDJSNDRzc1ZvZWRsOWpsV3paZmd6SUhY?=
 =?utf-8?B?T1hwUlUvekVGZHpnbWYrUTRWd0E4U3ZXS3N6Z1VYNkN2cmRHRHFldmZGYlg0?=
 =?utf-8?B?MnIwckhKWVlOL1orcm9MeHhVZFJQUzRSb1BtbWN4bmtReHZBQXlvalpzQ2Nm?=
 =?utf-8?B?NXpPSXZEM3BpclBmSDVteE40dGUvVlBXNjNEcjZmWmhZS2kyU3ZjSXZHc0lu?=
 =?utf-8?B?am5IMS9XNExkTmxUOHZMNGZvNnFYTG0wY2FLUDg5SGZrMlJtVEl5alFxTHBW?=
 =?utf-8?B?dzA2QjZOYnpNY2hETW40Ni91UUw5NTZrdVFlTWhrNkpGenFFYjdXcWlKNndn?=
 =?utf-8?B?Zmg3RUpSbVNYZzBia3dWK2N0TnJNSzdVajZZVExuRHFYN3E5YTZqaC9hM1p1?=
 =?utf-8?B?eVh4MTN1MVhXUjRxVFhqS2pGUkUrMGxyM1BtRDVmTjB4ZkozTDhPbWhZTko4?=
 =?utf-8?B?MVhGTkhIWUlUWXhjK1pJN3ZCUE91ZUIwaUNubHhzYjh3bWdxYWlSejVOUFBL?=
 =?utf-8?B?YnBVcTA1QVdDNXNPUHBlbnlXamZFTjR4TTR3SXRkSVFsVUxLbjNlM3BvRmNS?=
 =?utf-8?B?b3kxSHkxenlYMHpuTFNGcUtpdTNOMnpWb0JZNlgxYVRhc0lFekNYTVZocEg0?=
 =?utf-8?B?VGh6eFpiaXRYSS9oVnl0NkZEOXJvVlZObjVEV0wzZDZmb1JQN213UDR4SjNM?=
 =?utf-8?B?bjVGeXlqWlhyaUp6T1Y5M0sybG1PRXJHL09ScHpxa3JGZC92dXVxZElQcDJi?=
 =?utf-8?B?MWh1QVNNZjlwWEo3cTByZ2ZWbUNTUGt2blJaZzdWQkJOSjhIWWxkZjJ2ZUVm?=
 =?utf-8?B?QkFOd0tDMHZ2UzJZeGtGeVp6UTF6TWw3Vkg3Qmxyc25VVE1SM25XQjJsNDN0?=
 =?utf-8?B?NVFsRDlLc2RqUnNkbWk3dG9CSWNFMTF5TUlhYjNsNFdZdFc4eG8vOHhmbzFP?=
 =?utf-8?B?SXltRk1pcmU1VUlFdGR5bHA1cFZQRlVvcXBsS2pUTkgwL09wcTlSclNDTThs?=
 =?utf-8?B?azIyUkJsUUVEWlUwMHpwcm9oMjZxZnNIbXAwVU9yaFJaeDdTcVh3T2FKWVV0?=
 =?utf-8?B?Nm8xZ1hGSW01NUlwSDRFOCtBNDRwNnEzNmpra1Jjb2ZjZEE3VzFJL2Y1Z1ow?=
 =?utf-8?B?NnRjUDdPVmZiOTRQUXJKNGRXell2bnNTcUhRMWlhZTQ4SFFuTlBINFVoV2s0?=
 =?utf-8?B?Z1A5WFJuTUxxVDhzeStVTXV6SnlabGdwZkxPdjNRaE1FTUc4QUVuNHlvcWNm?=
 =?utf-8?B?czJuUTdtclhTOVRrQXlaTkMzRnAxWmtyNE1XWi9FaGlOaXNEU1lxZnlGY2tU?=
 =?utf-8?B?dWZQU2RBL3RaV3MrancxWWM0Tlg0bk1TaW5SY3EvSGNsS1JLM2t1NXNnUytU?=
 =?utf-8?B?YXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	PUrxXb3X4NH6Fsc53lDkPgSBXQXsaDzKW70Q/FCvHfodHJy+Z3Mr+cVWNF7y/SWJhF2dRX8bD2QVJsSyKX/HdQ2t1TEDEDn0uHEjePgbdpGWnjZqqWwIFWCiJd+QKlaMk/iAhEohQNwnEsVEgGsrZfrWrZ0saNbi/e1KBO5rVKqXvsiA3mc6mqsaOXur3rapDTP04/+7HFLGJqjjC01HIvGrC+CzIWH5RETlYIM1AJBWaCQtzy9nr8GJW02hFZ1Wit1TnlT9lJMhwKQrIO8EoGMqiaHdw45qkjcGyPRG9EXDowWZ9UgpWcdxalcha6LTK7mMddx82o3pAxGhlIbTKVHgU0hizKjyTMyS078viNrfWZ6SVhA7LHNFTQ4t5CC8BXfzBn3UrkcjhzAa86djZlmyWHM3/x+sRNbheMQPUJWHvmeMKx5mUwKFuOIWiXXs8jqHIwWHDSl7XcKoaJ/b+oDKX5T3aQ4y8P938yJmU++VLyFlFYb7X0fnIviKKdN5lGq8lFIk36vonlnRMgaKBvT6FTFn8rwRQhvS5yJS94GEosZi3YRR7oHLwxB2Gk3lgT0v13DyQBgjGsfG4m27UqK8wapmNlvaL/4sx6AYwRNVR1RCPSEw6e8dcOf8gQ9X
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB9865.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c69d2414-d1c5-4e79-4fc2-08dcf7dc9c11
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2024 05:43:26.2796
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZKB+HcqOpCTBvjJz6HYLO0jSENilaxscIEC6P9iCzWho7tW4kO0DFZDtrQ1DynQjJyCY6vb6P6kBdXZphwvXPgfzir1Y7SQ3caxsmNvnE6E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB12998

T24gRnJpLCBPY3QgMTgsIDIwMjQgNDoyOCBBTSBKYXNvbiBHdW50aG9ycGUgd3JvdGU6DQo+IE9u
IFdlZCwgT2N0IDA5LCAyMDI0IGF0IDEwOjU4OjU3QU0gKzA5MDAsIERhaXN1a2UgTWF0c3VkYSB3
cm90ZToNCj4gPiBUaGlzIHBhdGNoIHNlcmllcyBpbXBsZW1lbnRzIHRoZSBPbi1EZW1hbmQgUGFn
aW5nIGZlYXR1cmUgb24gU29mdFJvQ0UocnhlKQ0KPiA+IGRyaXZlciwgd2hpY2ggaGFzIGJlZW4g
YXZhaWxhYmxlIG9ubHkgaW4gbWx4NSBkcml2ZXJbMV0gc28gZmFyLg0KPiA+DQo+ID4gVGhpcyBz
ZXJpZXMgaGFzIGJlZW4gYmxvY2tlZCBiZWNhdXNlIG9mIHRoZSBoYW5nIGlzc3VlIG9mIHNycCAw
MDIgdGVzdFsyXSwNCj4gPiB3aGljaCB3YXMgYmVsaWV2ZWQgdG8gYmUgY2F1c2VkIGFmdGVyIGFw
cGx5aW5nIHRoZSBjb21taXQgOWI0YjdjMWY5ZjU0DQo+ID4gKCJSRE1BL3J4ZTogQWRkIHdvcmtx
dWV1ZSBzdXBwb3J0IGZvciByeGUgdGFza3MiKS4gTXkgcGF0Y2hlcyBhcmUgZGVwZW5kZW50DQo+
ID4gb24gdGhlIGNvbW1pdCBiZWNhdXNlIHRoZSBPRFAgZmVhdHVyZSByZXF1aXJlcyBzbGVlcGlu
ZyBpbiBrZXJuZWwgc3BhY2UsDQo+ID4gYW5kIGl0IGlzIGltcG9zc2libGUgd2l0aCB0aGUgZm9y
bWVyIHRhc2tsZXQgaW1wbGVtZW50YXRpb24uDQo+ID4NCj4gPiBBY2NvcmRpbmcgdG8gdGhlIG9y
aWdpbmFsIHJlcG9ydGVyWzNdLCB0aGUgaGFuZyBpc3N1ZSBpcyBhbHJlYWR5IGdvbmUgaW4NCj4g
PiB2Ni4xMC4gQWRkaXRpb25hbGx5LCB0YXNrbGV0IGlzIG1hcmtlZCBkZXByZWNhdGVkWzRdLiBJ
IHRoaW5rIHRoZSByeGUNCj4gPiBkcml2ZXIgaXMgcmVhZHkgdG8gYWNjZXB0IHRoaXMgc2VyaWVz
IHNpbmNlIHRoZXJlIGlzIG5vIGxvbmdlciBhbnkgcmVhc29uDQo+ID4gdG8gY29uc2lkZXIgcmV2
ZXJ0aW5nIGJhY2sgdG8gdGhlIG9sZCB0YXNrbGV0Lg0KPiANCj4gT2theSwgYW5kIGl0IHNlZW1z
IHdlIGFyZSBqdXN0IGlnbm9yaW5nIHRoZSByeGUgYnVncyB0aGVzZSBkYXlzLCBzbw0KPiB3aHkg
bm90PyBMZXRzIGxvb2sgYXQgaXQNCg0KSGkgSmFzb24sDQoNCldoYXQgd2UgaGF2ZSBzZWVuIHNv
IGZhciBzdWdnZXN0cyB0aGF0IHRoZSBoYW5nIGlzIGRlcml2ZWQgZnJvbSBhIHBvdGVudGlhbCB0
aW1pbmcgaXNzdWUgaW4gc3JwIGRyaXZlcnMuDQpJIGJlbGlldmUgaXQgY2Fubm90IGJlIGEgcmVh
c29uIHRvIGRlbGF5IHRoaXMgZmVhdHVyZSBpbmRlZmluaXRlbHkuDQoNCkhvd2V2ZXIsIEkgdW5k
ZXJzdGFuZCB5b3VyIHN0YW5jZSBhcyBhIG1haW50YWluZXIgaXMgbm90IHdyb25nLiBJdCBpcyBu
YXR1cmFsIHlvdSB3YW50IHRvIGltcHJvdmUNCm92ZXJhbGwgcXVhbGl0eSBvZiB0aGUgaW5maW5p
YmFuZCBzdWJzeXN0ZW0sIGluY2x1ZGluZyB0aGUgVUxQIGRyaXZlcnMuIEkgYW0gY29tbWl0dGVk
IHRvDQptYWludGFpbmluZyBhbmQgaW1wcm92aW5nIHRoZSByeGUgYW5kIHVuZGVybHlpbmcgZHJp
dmVycywgYnV0IEkgYW0gc29ycnkgdGhhdCBJIGNhbm5vdCB0YWtlDQp0aGUgZW5vdWdoIHRpbWUg
dG8gZGVsdmUgaW50byB0aGUgb3RoZXIgY29tcG9uZW50cyByaWdodCBub3cuDQoNCkkgbXVzdCBs
ZWF2ZSBpdCB0byB5b3Ugd2hldGhlciB0byBjb250aW51ZSB0byBibG9jayBteSBwYXRjaHNldCBv
ciBub3QuDQpZb3UgYXJlIHRoZSBtYWludGFpbmVyIGFuZCBoYXZlIHRoZSBmaW5hbCB3b3JkIG9u
IGl0Lg0KDQpUaGFua3MsDQpEYWlzdWtlIE1hdHN1ZGENCg0KPiANCj4gSmFzb24NCg==


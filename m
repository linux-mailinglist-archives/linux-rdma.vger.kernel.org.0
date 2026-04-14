Return-Path: <linux-rdma+bounces-19316-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cHBLM7643WkRiQkAu9opvQ
	(envelope-from <linux-rdma+bounces-19316-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Apr 2026 05:47:10 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B08E3F557F
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Apr 2026 05:47:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DDD9B3018BFF
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Apr 2026 03:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D38931326C;
	Tue, 14 Apr 2026 03:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="lEs12Y/Y"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C072EFDAF;
	Tue, 14 Apr 2026 03:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776138413; cv=none; b=B+zpjsxkcfyKrCw26IOA5/5rQBgnayINtnMucsS6O4RR6knFQhj5bDKMoLeSbnr6q568fQnC/HFUmopIKwAmq8p8yidvyZ5w9b4DpgT0AU6arNyZR8VaNdZ6MY1uZc0kTuB8ddyklXyLzAQ9AePZh5Sg3PkoZelnUXvtidpPAis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776138413; c=relaxed/simple;
	bh=h+8tYZnDNut7N+qjHrTNV6ZQ1BZ4tm0AsavZ8FV5pjw=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c7E65SXg814AkXkiZRzci7POQBH6WioYwPWIBLzEzg0AsylJwk18l5KKCuGFoP72HlodHfU1Zeb9M0VXm39WSzJyvfrhtN6I2PQOYo+0n/UYqzkLRe4RXiDpjRSpsLuYEuvdI4wuEnDRNUv7KD+bY3CcgIdeo6nipyrjzlB8oZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=lEs12Y/Y; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63DL7lus1628427;
	Mon, 13 Apr 2026 20:46:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=YiWf24idfLOna0cEbxoX+AYgB
	F1BS4mOvgW6ikn7h3g=; b=lEs12Y/Y8KuYm36DSYCd0FkR2ncwV+4tdoCCTmzP7
	FgVH55RbnQ0Od5s5+gnnoDgrNVz4nrMBJT1FLpzBE2d9wy+N9vAIhPNTF7lxYkw6
	CMFP/3eP29kJXEGIwAvzyEoXjm9xJk0B7tQaqR88s4d1zasS31A7E2IIrbasPXe/
	CbW1McULEjqDgnLwHp3wzoBFD6gcQmCkVxd0nPcYfJSHZ+bsmarRYD/Ux3zdPg5G
	3F0/Iwpj2MIWWCIz78QzdmiJs0Ssida/o2DcA4Fs7FFOOQAxiHU3Cj9rRX080ikh
	8OEoYGECYgkB+QgXZR4R9qhhWKxXGb5Wmi45uKcBNGCYw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4dh84qrrpf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Apr 2026 20:46:34 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 13 Apr 2026 20:46:34 -0700
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 13 Apr 2026 20:46:33 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 13 Apr 2026 20:46:33 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id 181F33F703F;
	Mon, 13 Apr 2026 20:46:26 -0700 (PDT)
Date: Tue, 14 Apr 2026 09:16:25 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: Paolo Abeni <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-rdma@vger.kernel.org>, <sgoutham@marvell.com>,
        <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <donald.hunter@gmail.com>, <horms@kernel.org>,
        <jiri@resnulli.us>, <chuck.lever@oracle.com>, <matttbe@kernel.org>,
        <cjubran@nvidia.com>, <saeedm@nvidia.com>, <leon@kernel.org>,
        <tariqt@nvidia.com>, <mbloch@nvidia.com>, <dtatulea@nvidia.com>
Subject: Re: [PATCH v11 net-next 5/7] octeontx2-af: npc: cn20k: add subbank
 search order control
Message-ID: <ad24kZnhUXkysNKF@rkannoth-OptiPlex-7090>
References: <20260409025055.1664053-1-rkannoth@marvell.com>
 <20260409025055.1664053-6-rkannoth@marvell.com>
 <b9ffa72d-ebe2-4fd1-b668-93620f206179@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <b9ffa72d-ebe2-4fd1-b668-93620f206179@redhat.com>
X-Proofpoint-ORIG-GUID: orukX0zeH64LpU1d97G3ejZgOW0NItZH
X-Proofpoint-GUID: orukX0zeH64LpU1d97G3ejZgOW0NItZH
X-Authority-Analysis: v=2.4 cv=arqCzyZV c=1 sm=1 tr=0 ts=69ddb89a cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=kj9zAlcOel0A:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=EAYMVhzMl8SCOHhVQcBL:22 a=c92rfblmAAAA:8
 a=M5GUcnROAAAA:8 a=20KFwNOVAAAA:8 a=f7ZYTRpxgPyUO7SbQ74A:9 a=CjuIK1q_8ugA:10
 a=GvGzcOZaWPEFPQC_NcjD:22 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE0MDAzMiBTYWx0ZWRfX2dHgW4gWTWlP
 F9oSOU9aFOwtRZ8D9tsqF8dPO8PR3nEbQMFIQV/+luW4ZrAhnwBGd2LeL7esO2Q6frI+YN/8LRW
 qnIRV7q78yJFRo6oP5TafZMqOQP0GspNGKHc0zNuYj7Z4Mgdcoqk7qt1ROuIttUnZUH1AulJK2t
 Cwq0ceAgeupvln7oKhopOqAZ3t7WG0TeU/rlUiJEbp6tvQdhO/fgNZfVTTi70AJlZvJVstABvER
 mPWveEzBRFDBQgc5EPlmp2+82yTkpkEcBDdY2S6B09qJP8NSz4yMwSpY+JntL0frjLhaLxR3dvq
 1vI3Mmd5rBJUhNhj9OucHostK+SI/xRU6nZfxd2ALOcqSlI1RKRT43lE0KHUQ0qKryrbfjPvno/
 2mLzhQ2lad8XdsrfGXj3B2CQ6jiZD+O4rbPvsMSfXs4mw7sGh9Tt1fdQBNxMYsYsXYXX8+kzqxl
 BSncZbX3byRG9W7fLIA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-13_03,2026-04-13_04,2025-10-01_01
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19316-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[20];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,marvell.com,lunn.ch,davemloft.net,google.com,kernel.org,gmail.com,resnulli.us,oracle.com,nvidia.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[marvell.com:dkim,sashiko.dev:url];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rkannoth@marvell.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 6B08E3F557F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 2026-04-13 at 18:26:00, Paolo Abeni (pabeni@redhat.com) wrote:
> > +	xa_for_each(&npc_priv.xa_sb_free, index, v) {
> > +		val = xa_to_value(v);
> > +		fslots[fcnt][0] = index;
> > +		fslots[fcnt][1] = val;
> > +		xa_erase(&npc_priv.xa_sb_free, index);
> > +		fcnt++;
> > +	}
> > +
> > +	/* xa_store() is done under lock. If xa_store fails
> > +	 * ,no rollback is planned as it might also fail.
>
> Why do you need to go throuh erase and add loop? Why can't you directly
> xa_store() the new value? Note that xa_store() can fail due to memory
> pressure.
>
> Avoiding the previous erase will prevent deallocation and re allocation
> and will avoid any reasonable xa_store() failure.
ACK.

>
> AFAICS there are a few more items reported by sashiko, please have a look:
>
> https://sashiko.dev/#/patchset/20260409025055.1664053-1-rkannoth%40marvell.com
>
> /P
>

Patch 1: [PATCH v11 net-next 1/7] octeontx2-af: npc: cn20k: debugfs enhancements

>"+static u64 dstats[MAX_NUM_BANKS][MAX_SUBBANK_DEPTH * MAX_NUM_SUB_BANKS] = {};
>Is it safe to use a static global array here? If multiple RVU AF devices exist
>in the system, it looks like they might share this array and overwrite each
>other's hardware statistics."
There is only one single rvu AF device in the system. Ignore the comment.
as it is false positive.

>"Also, since there are no locks, could concurrent reads of the debugfs file by
>multiple threads cause a data race and corrupt the stored statistics?"
ACK. added a mutex lock.

>"Since en_map is added to the global npc_priv structure, is it ever explicitly
>cleared during device initialization?"
npc_priv is defined as static. So all fields are set to 0, by default.
Anyway, added bitmap clear to get rid of this AI review warning.

>"Does updating dstats inline during the seq_file show callback break the
>statistics if the buffer overflows?"
ACK. Used seq open with size() API to set required size of buffer at the start.
Added a check to see if there is a buffer over flow by counting buffers wrote into
seq_file. dstats are "delta stats", and used for debugging.

>"Does updating dstats inline during the seq_file show callback break the
>statistics if the buffer overflows?Does updating dstats inline during the seq_file show callback break the
>statistics if the buffer overflows?"
ACK.

>"When seq_read detects the overflow, it allocates a larger buffer and calls
>this show callback again from the beginning. During the retry,
>stats == dstats[bank][idx] will evaluate to true because the array was
>already updated, which skips all the previously overflowing entries."
ACK.

>"This isn't a bug, but using the ternary operator for its void side-effects
>is generally avoided in the kernel. Could this be written using an if/else
>block, or the assign_bit() macro instead?"
ACK.

>"Since en_map is added to the global npc_priv structure, is it ever explicitly
>cleared during device initialization?
>If the PCI device is unbound and rebound via sysfs, could en_map retain bits
>from the previous lifecycle and cause the new mismatch debugfs file to falsely
>report old enabled rules as mismatched?"
ACK. Reset bitmap to zero on deinit.

Patch 2: [PATCH v11 net-next 2/7] net/mlx5e: heap-allocate devlink param values

>Could we avoid the dynamic allocation entirely? Instead of storing all four
>values at once, could a single union devlink_param_value be declared inside
>the loop, populated, and immediately assigned to the respective config field?
>This would reduce the stack usage to a single union, avoiding both the frame
>size warning and the new memory allocation failure path."
ACK.

Patch 3: [PATCH v11 net-next 3/7] devlink: Change function syntax.

>"The commit message notes that exported APIs will be updated to pass the
>unions by pointer. Is this incomplete? Exported APIs like
>devl_param_driverinit_value_set and the validate callback in struct
>devlink_param still appear to take the union by value, which might continue
>to push the large structure onto the stack during validation."
ACK.

>"This isn't a bug, but it looks like an automated search and replace
>accidentally modified the word "values" in this comment."
ACK.

Patch 5: [PATCH v11 net-next 5/7] octeontx2-af: npc: cn20k: add subbank search order control

>Does this code overflow uslots[]?
>Looking at npc_priv_init(), num_subbanks is populated directly from the
>hardware register NPC_AF_CONST2. While it ensures the value is a power of 2,
>there doesn't seem to be a check that restricts it to MAX_NUM_SUB_BANKS.
>If the hardware reports a value larger than 32, ucnt could exceed the
>bounds of the stack-allocated uslots array.
ACK.

>Can this approach cause a permanent leak of the erased subbanks?
>If any xa_store() call fails, the function jumps to fail_used and returns
>without rolling back the state. Since the subbanks were already erased from
>the xarray into the local stack arrays, failing to re-insert them leaves the
>hardware allocator state partially empty and corrupts it for the lifetime of
>the system.
>Would it be safer to pre-allocate with xa_reserve(), or build new xarrays and
>swap them in on success?
Used xa_store without xa_erase. If xa_store fails due to memory pressure, error is
unrecoverable as this error can happen in between (for loop).

[PATCH v11 net-next 6/7] octeontx2-af: npc: cn20k: dynamically allocate and free default MCAM entries

>"The NIX_LF_DONT_FREE_DFT_IDXS flag is read directly from the mailbox message
>structure. Since mailbox messages can be initiated by Virtual Functions, what
>prevents an unprivileged VF from repeatedly allocating and freeing LFs with
>this flag set to exhaust the hardware MCAM entries?"
rvu_mbox_handler_nix_lf_alloc() ---> npc_cn20k_dft_rules_alloc(). npc_cn20k_dft_rules_alloc() will alloc default entries if and only if it is not already there. So if
VF calls alloc and free LF without setting the flag, the default entries wont be allocated or freed.

>Are the values in ptr[] virtual or physical MCAM indices? It appears that
>npc_cn20k_dft_rules_idx_get() retrieves virtual indices, but they are used
>here as direct indices into mcam->entry2pfvf_map and passed to
>npc_mcam_clear_bit(). Since those structures are sized for physical indices,
>could this cause an out-of-bounds memory corruption or an integer underflow?
default entries are allways allocated by setting "ref_entry" field in struct npc_mcam_alloc_entry_req. Then, rvu_mbox_handler_npc_mcam_alloc_entry() wont return a virtual
mcam index.

>If xa_erase() fails above and returns NULL, ptr[i] is not cleared and the
>code falls through to the free_rules label. Will this result in
>unconditionally calling npc_cn20k_idx_free() on the stale index, potentially
>causing a double-free?
ACK.

>Furthermore, if a VF manually frees its default MCAM rules via the
>NPC_MCAM_FREE_ENTRY mailbox command before this NIX LF teardown occurs,
>npc_cn20k_idx_free() will be called during that manual free. Since the manual
>free does not remove the index from xa_pf2dfl_rmap, could this teardown path
>fetch the same index and attempt to free it again?
default mcam rules are allocated in rvu_mbox_handler_nix_lf_alloc(). Not thru
NPC_MCAM_FREE_ENTRY. if it does intentionally, then it is a violation. we have dev_err() there, and need to debug at User point.

>Does the caller of this function properly handle negative error codes?
>For example, in npc_enadis_default_mce_entry() and
>npc_enadis_default_entries(), the returned index is passed directly to
>npc_enable_mcam_entry() and nix_update_mce_list() without checking for a
>negative value. This could lead to a WARN(1) in npc_enable_mcam_entry() or an
>out-of-bounds write in nix_update_mce_list().
We intentionally did the change to find out the flow which pass wrong mcam index.
So we need a splat using WARN(1)

>Here, index is a physical index from the bitmap iteration, but the values
>returned into dft_idxs[] by npc_cn20k_dft_rules_idx_get() are virtual
>indices. Will this comparison always fail, causing default rules to be
>erroneously physically freed?
No. default indexes are not virtual. This is ensured during allocation itself.

>Additionally, if the NIX LF is freed with NIX_LF_DONT_FREE_DFT_IDXS to
>preserve default rules, the ownership mapping is cleared here.
ACK.

>Upon
>re-allocation, npc_cn20k_dft_rules_alloc() will detect the rules in
>xa_pf2dfl_rmap but won't restore the ownership in entry2pfvf_map, meaning
>subsequent operations on these rules will fail verification.
ACK.

>Does this make the firmware layout dependent on the internal size of
>ikpu_action_entries?
Yes.
>If future kernel versions add new packet kinds and increase the size of
>this array, older firmware files will fail this bounds check and be rejected.
struct npc_kpu_profile_fwdata does not have a field to indicate the size of ikpu_action_entries.
We can't modify the structure as it would break backward compatability on old fw.

>ill this trigger a compiler warning or build failure on strict builds?
>The min() macro performs strict type checking, and fw_kpu->entries appears
>to be a signed int, while rvu->hw->npc_kpu_entries is an unsigned u16.
ACK.

>Could a negative value in fw_kpu->entries cause an integer underflow here?
>If fw_kpu->entries is read from untrusted firmware as a negative value, the
>offset calculation can underflow the size_t offset variable.
>This would bypass the subsequent bounds check because the wrapped offset
>plus hdr_sz wraps again to a small positive value.
>On the next iteration, calculating fw_kpu = fw->data + offset could result
>in an out-of-bounds memory read.
Addded check to return on invalid value.

>Does modifying profile->kpu here corrupt the global default profile state?
>Earlier in the flow, profile->kpu is initialized to point to the global
>static array npc_kpu_profiles. Allocating device-managed memory into
>profile->kpu[kpu].cam2 overwrites this global state with device-specific
>pointers.
>When the device is unbound and the memory is freed, could this leave dangling
>pointers in the global array for other RVU devices in the system? The same
>applies to the legacy firmware parsing path where cam[entry] is overwritten.

>We are not using profile->kpu after unbind and memory is freed. During reinit, these
>fields are intialized again. So there is no issue with it.
>
>Could this printk formatter read past the end of the profile name?
>The name array in the firmware header is 32 bytes. If a user provides a
>firmware file with exactly 32 non-null characters, the string will lack a
>null terminator.
>Printing this with %s can leak adjacent heap memory contents into the kernel
>log. Using %.32s would ensure the read stays within bounds.
ACK.

>Do these fields require an endianness conversion before use?
>The 16-bit values like dp0, dp1, and dp2 are read directly from the firmware
>blob.
>If the firmware payload uses little-endian byte order, applying these
>directly to hardware registers could result in misprogramming on big-endian
>architectures. Would it be safer to use le16_to_cpu() here?
s/w is validated only for little endian as HW is little endian. if big endian required,
we will provide seperate firmware for the same.


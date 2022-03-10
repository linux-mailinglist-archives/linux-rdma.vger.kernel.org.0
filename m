Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71D1F4D4106
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Mar 2022 07:13:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238151AbiCJGOC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 10 Mar 2022 01:14:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235316AbiCJGOA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 10 Mar 2022 01:14:00 -0500
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63E9356226;
        Wed,  9 Mar 2022 22:12:57 -0800 (PST)
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1646892775;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cPVkXjs3RsD8AKp7Bxn85oOAZqCe3ygnOcDE6loKKe8=;
        b=ComhsVyB6hJ4A7cpyWjJd9LvTxrR6o7syk4CuTqyKt4Ybs8NffEqmbW+aAhqgky4n1yik8
        /rh7WN7tyk0zx2UYWX7IGxPgq8pDuutE+XjbdRrP3YMRaQmQeX1Tg5M+1MnQshbRRVzpt9
        jCYKRt/EjfiKRwP6NUkpecAST0zq11Y=
Date:   Thu, 10 Mar 2022 06:12:54 +0000
Content-Type: multipart/mixed;
 boundary="--=_RainLoop_652_197531094.1646892774"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   "Yajun Deng" <yajun.deng@linux.dev>
Message-ID: <18cd9e734496d2ab93cbe77d446fd33d@linux.dev>
Subject: Re: [PATCH rdma-next] Revert "RDMA/core: Fix ib_qp_usecnt_dec()
 called when error"
To:     "Leon Romanovsky" <leon@kernel.org>
Cc:     "Leon Romanovsky" <leonro@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        "Jason Gunthorpe" <jgg@nvidia.com>
In-Reply-To: <74c11029adaf449b3b9228a77cc82f39e9e892c8.1646851220.git.leonro@nvidia.com>
References: <74c11029adaf449b3b9228a77cc82f39e9e892c8.1646851220.git.leonro@nvidia.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


----=_RainLoop_652_197531094.1646892774
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi, Leon.=0ACan you test the attached patch?  If revert it, ib_qp_usecnt_=
dec() would called before ib_qp_usecnt_inc() when =0Acreate_xrc_qp_user()=
 return error.=0A=0AThanks=EF=BC=81=0A -- Yajun=0A=0AMarch 10, 2022 2:42 =
AM, "Leon Romanovsky" <leon@kernel.org> wrote:=0A=0A> From: Leon Romanovs=
ky <leonro@nvidia.com>=0A> =0A> This reverts commit 7c4a539ec38f4ce400a0f=
3fcb5ff6c940fcd67bb. which=0A> causes to the following error in mlx4.=0A>=
 =0A> [ 679.401416] ------------[ cut here ]------------=0A> [ 679.403542=
] Destroy of kernel CQ shouldn't fail=0A> [ 679.403580] WARNING: CPU: 4 P=
ID: 18064 at include/rdma/ib_verbs.h:3936=0A> mlx4_ib_dealloc_xrcd+0x12e/=
0x1b0 [mlx4_ib]=0A> [ 679.406534] Modules linked in: bonding ib_ipoib ip_=
gre ipip tunnel4 geneve rdma_ucm nf_tables=0A> ib_umad mlx4_en mlx4_ib ib=
_uverbs mlx4_core ip6_gre gre ip6_tunnel tunnel6 iptable_raw openvswitch=
=0A> nsh rpcrdma ib_iser libiscsi scsi_transport_iscsi rdma_cm iw_cm ib_c=
m ib_core xt_conntrack=0A> xt_MASQUERADE nf_conntrack_netlink nfnetlink x=
t_addrtype iptable_nat nf_nat br_netfilter overlay=0A> fuse [last unloade=
d: mlx4_core]=0A> [ 679.413323] CPU: 4 PID: 18064 Comm: ibv_xsrq_pingpo N=
ot tainted 5.17.0-rc7_master_62c6ecb #1=0A> [ 679.415043] Hardware name: =
QEMU Standard PC (Q35 + ICH9, 2009), BIOS=0A> rel-1.13.0-0-gf21b5a4aeb02-=
prebuilt.qemu.org 04/01/2014=0A> [ 679.417285] RIP: 0010:mlx4_ib_dealloc_=
xrcd+0x12e/0x1b0 [mlx4_ib]=0A> [ 679.418455] Code: 1e 93 08 00 40 80 fd 0=
1 0f 87 fa f1 04 00 83 e5 01 0f 85 2b ff ff ff 48 c7 c7=0A> 20 4f b6 a0 c=
6 05 fd 92 08 00 01 e8 47 c9 82 e2 <0f> 0b e9 11 ff ff ff 0f b6 2d eb 92 =
08 00 40 80=0A> fd 01 0f 87 b1 f1=0A> [ 679.421993] RSP: 0018:ffff8881a49=
57750 EFLAGS: 00010286=0A> [ 679.423047] RAX: 0000000000000000 RBX: ffff8=
881ac4b6800 RCX: 0000000000000000=0A> [ 679.424420] RDX: 0000000000000027=
 RSI: 0000000000000004 RDI: ffffed103492aedc=0A> [ 679.425818] RBP: 00000=
00000000000 R08: 0000000000000001 R09: ffff8884d2e378eb=0A> [ 679.427186]=
 R10: ffffed109a5c6f1d R11: 0000000000000001 R12: ffff888132620000=0A> [ =
679.428553] R13: ffff8881a4957a90 R14: ffff8881aa2d4000 R15: ffff8881a495=
7ad0=0A> [ 679.429939] FS: 00007f0401747740(0000) GS:ffff8884d2e00000(000=
0) knlGS:0000000000000000=0A> [ 679.431548] CS: 0010 DS: 0000 ES: 0000 CR=
0: 0000000080050033=0A> [ 679.432695] CR2: 000055f8ae036118 CR3: 00000001=
2fe94005 CR4: 0000000000370ea0=0A> [ 679.434099] DR0: 0000000000000000 DR=
1: 0000000000000000 DR2: 0000000000000000=0A> [ 679.435498] DR3: 00000000=
00000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400=0A> [ 679.436914] Ca=
ll Trace:=0A> [ 679.437510] <TASK>=0A> [ 679.438042] ib_dealloc_xrcd_user=
+0xce/0x120 [ib_core]=0A> [ 679.439245] ib_uverbs_dealloc_xrcd+0xad/0x210=
 [ib_uverbs]=0A> [ 679.440385] uverbs_free_xrcd+0xe8/0x190 [ib_uverbs]=0A=
> [ 679.441453] destroy_hw_idr_uobject+0x7a/0x130 [ib_uverbs]=0A> [ 679.4=
42568] uverbs_destroy_uobject+0x164/0x730 [ib_uverbs]=0A> [ 679.443699] u=
obj_destroy+0x72/0xf0 [ib_uverbs]=0A> [ 679.444653] ib_uverbs_cmd_verbs+0=
x19fb/0x3110 [ib_uverbs]=0A> [ 679.445805] ? entry_SYSCALL_64_after_hwfra=
me+0x44/0xae=0A> [ 679.446893] ? uverbs_finalize_object+0x50/0x50 [ib_uve=
rbs]=0A> [ 679.448037] ? check_chain_key+0x24a/0x580=0A> [ 679.448919] ? =
uverbs_fill_udata+0x540/0x540 [ib_uverbs]=0A> [ 679.450040] ? check_chain=
_key+0x24a/0x580=0A> [ 679.450934] ? remove_vma+0xca/0x100=0A> [ 679.4517=
36] ? lock_acquire+0x1b1/0x4c0=0A> [ 679.452553] ? lock_acquire+0x1b1/0x4=
c0=0A> [ 679.453393] ? ib_uverbs_ioctl+0x11e/0x260 [ib_uverbs]=0A> [ 679.=
454438] ? __might_fault+0xb8/0x160=0A> [ 679.455267] ? lockdep_hardirqs_o=
n_prepare+0x400/0x400=0A> [ 679.456329] ib_uverbs_ioctl+0x169/0x260 [ib_u=
verbs]=0A> [ 679.457384] ? ib_uverbs_ioctl+0x11e/0x260 [ib_uverbs]=0A> [ =
679.458443] ? ib_uverbs_cmd_verbs+0x3110/0x3110 [ib_uverbs]=0A> [ 679.459=
598] ? asm_sysvec_apic_timer_interrupt+0x12/0x20=0A> [ 679.460689] ? mark=
_held_locks+0x9f/0xe0=0A> [ 679.461577] __x64_sys_ioctl+0x856/0x1550=0A> =
[ 679.462439] ? vfs_fileattr_set+0x9f0/0x9f0=0A> [ 679.463328] ? __up_rea=
d+0x1a3/0x750=0A> [ 679.464102] ? up_write+0x4a0/0x4a0=0A> [ 679.464865] =
? __vm_munmap+0x22e/0x2e0=0A> [ 679.465690] ? __x64_sys_brk+0x840/0x840=
=0A> [ 679.466519] ? __cond_resched+0x17/0x80=0A> [ 679.467340] ? lockdep=
_hardirqs_on_prepare+0x286/0x400=0A> [ 679.468373] ? syscall_enter_from_u=
ser_mode+0x1d/0x50=0A> [ 679.469411] do_syscall_64+0x3d/0x90=0A> [ 679.47=
0174] entry_SYSCALL_64_after_hwframe+0x44/0xae=0A> [ 679.471191] RIP: 003=
3:0x7f040191917b=0A> [ 679.471961] Code: 0f 1e fa 48 8b 05 1d ad 0c 00 64=
 c7 00 26 00 00 00 48 c7 c0 ff ff ff ff c3 66=0A> 0f 1f 44 00 00 f3 0f 1e=
 fa b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d ed ac 0c 0=
0=0A> f7 d8 64 89 01 48=0A> [ 679.475467] RSP: 002b:00007ffce7c4a038 EFLA=
GS: 00000246 ORIG_RAX: 0000000000000010=0A> [ 679.477014] RAX: ffffffffff=
ffffda RBX: 00007ffce7c4a158 RCX: 00007f040191917b=0A> [ 679.478434] RDX:=
 00007ffce7c4a140 RSI: 00000000c0181b01 RDI: 0000000000000003=0A> [ 679.4=
79840] RBP: 00007ffce7c4a120 R08: 000055f8ae02d080 R09: 0000000000000000=
=0A> [ 679.481231] R10: 0000000000000000 R11: 0000000000000246 R12: 00007=
ffce7c4a120=0A> [ 679.482630] R13: 00007ffce7c4a110 R14: 000055f8ae02f440=
 R15: 0000000000000000=0A> [ 679.484003] </TASK>=0A> [ 679.484535] irq ev=
ent stamp: 62713=0A> [ 679.485313] hardirqs last enabled at (62723): [<ff=
ffffff81480f17>] __up_console_sem+0x67/0x70=0A> [ 679.487019] hardirqs la=
st disabled at (62730): [<ffffffff81480efc>] __up_console_sem+0x4c/0x70=
=0A> [ 679.488734] softirqs last enabled at (62220): [<ffffffff8135679f>]=
 __irq_exit_rcu+0x11f/0x170=0A> [ 679.490569] softirqs last disabled at (=
62215): [<ffffffff8135679f>] __irq_exit_rcu+0x11f/0x170=0A> [ 679.503168]=
 ---[ end trace 0000000000000000 ]---=0A> =0A> Fixes: 7c4a539ec38f ("RDMA=
/core: Fix ib_qp_usecnt_dec() called when error")=0A> Signed-off-by: Leon=
 Romanovsky <leonro@nvidia.com>=0A> ---=0A> drivers/infiniband/core/uverb=
s_cmd.c | 1 +=0A> drivers/infiniband/core/uverbs_std_types_qp.c | 1 +=0A>=
 drivers/infiniband/core/verbs.c | 3 ++-=0A> 3 files changed, 4 insertion=
s(+), 1 deletion(-)=0A> =0A> diff --git a/drivers/infiniband/core/uverbs_=
cmd.c b/drivers/infiniband/core/uverbs_cmd.c=0A> index 4437f834c0a7..6b63=
93176b3c 100644=0A> --- a/drivers/infiniband/core/uverbs_cmd.c=0A> +++ b/=
drivers/infiniband/core/uverbs_cmd.c=0A> @@ -1437,6 +1437,7 @@ static int=
 create_qp(struct uverbs_attr_bundle *attrs,=0A> ret =3D PTR_ERR(qp);=0A>=
 goto err_put;=0A> }=0A> + ib_qp_usecnt_inc(qp);=0A> =0A> obj->uevent.uob=
ject.object =3D qp;=0A> obj->uevent.event_file =3D READ_ONCE(attrs->ufile=
->default_async_file);=0A> diff --git a/drivers/infiniband/core/uverbs_st=
d_types_qp.c=0A> b/drivers/infiniband/core/uverbs_std_types_qp.c=0A> inde=
x 75353e09c6fe..dd1075466f61 100644=0A> --- a/drivers/infiniband/core/uve=
rbs_std_types_qp.c=0A> +++ b/drivers/infiniband/core/uverbs_std_types_qp.=
c=0A> @@ -254,6 +254,7 @@ static int UVERBS_HANDLER(UVERBS_METHOD_QP_CREA=
TE)(=0A> ret =3D PTR_ERR(qp);=0A> goto err_put;=0A> }=0A> + ib_qp_usecnt_=
inc(qp);=0A> =0A> if (attr.qp_type =3D=3D IB_QPT_XRC_TGT) {=0A> obj->uxrc=
d =3D container_of(xrcd_uobj, struct ib_uxrcd_object,=0A> diff --git a/dr=
ivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c=0A> index=
 bc9a83f1ca2d..a9819c40a140 100644=0A> --- a/drivers/infiniband/core/verb=
s.c=0A> +++ b/drivers/infiniband/core/verbs.c=0A> @@ -1245,7 +1245,6 @@ s=
tatic struct ib_qp *create_qp(struct ib_device *dev, struct ib_pd *pd,=0A=
> if (ret)=0A> goto err_security;=0A> =0A> - ib_qp_usecnt_inc(qp);=0A> rd=
ma_restrack_add(&qp->res);=0A> return qp;=0A> =0A> @@ -1346,6 +1345,8 @@ =
struct ib_qp *ib_create_qp_kernel(struct ib_pd *pd,=0A> if (IS_ERR(qp))=
=0A> return qp;=0A> =0A> + ib_qp_usecnt_inc(qp);=0A> +=0A> if (qp_init_at=
tr->cap.max_rdma_ctxs) {=0A> ret =3D rdma_rw_init_mrs(qp, qp_init_attr);=
=0A> if (ret)=0A> -- =0A> 2.35.1

----=_RainLoop_652_197531094.1646892774
Content-Type: application/octet-stream;
 name="0001-RDMA-core-Fix-destroy-CQ-error-in-mlx4.patch"
Content-Disposition: attachment;
 filename="0001-RDMA-core-Fix-destroy-CQ-error-in-mlx4.patch"
Content-Transfer-Encoding: base64

RnJvbSBkYmFlOWEwODIyMTY1ZjdjZDUxZjAzZjFkYzk4MDdlZTFiZGY1ZGQ3IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBZYWp1biBEZW5nIDx5YWp1bi5kZW5nQGxpbnV4LmRl
dj4KRGF0ZTogVGh1LCAxMCBNYXIgMjAyMiAxMTo1MDo1MSArMDgwMApTdWJqZWN0OiBbUEFU
Q0hdIFJETUEvY29yZTogRml4IGRlc3Ryb3kgQ1EgZXJyb3IgaW4gbWx4NAoKVGhlcmUgYXJl
IE5VTEwgZm9yIHBkLHNlbmRfY3EscmVjdl9jcSxzcnEgaW4gY3JlYXRlX3hyY19xcF91c2Vy
KCksIHNvCmliX3FwX3VzZWNudF9pbmMoKSBzaG91bGQgYWZ0ZXIgdGhhdC4KCiBbICA2Nzku
NDAxNDE2XSAtLS0tLS0tLS0tLS1bIGN1dCBoZXJlIF0tLS0tLS0tLS0tLS0KIFsgIDY3OS40
MDM1NDJdIERlc3Ryb3kgb2Yga2VybmVsIENRIHNob3VsZG4ndCBmYWlsCiBbICA2NzkuNDAz
NTgwXSBXQVJOSU5HOiBDUFU6IDQgUElEOiAxODA2NCBhdCBpbmNsdWRlL3JkbWEvaWJfdmVy
YnMuaDozOTM2IG1seDRfaWJfZGVhbGxvY194cmNkKzB4MTJlLzB4MWIwIFttbHg0X2liXQog
WyAgNjc5LjQwNjUzNF0gTW9kdWxlcyBsaW5rZWQgaW46IGJvbmRpbmcgaWJfaXBvaWIgaXBf
Z3JlIGlwaXAgdHVubmVsNCBnZW5ldmUgcmRtYV91Y20gbmZfdGFibGVzIGliX3VtYWQgbWx4
NF9lbiBtbHg0X2liIGliX3V2ZXJicyBtbHg0X2NvcmUgaXA2X2dyZSBncmUgaXA2X3R1bm5l
bCB0dW5uZWw2IGlwdGFibGVfcmF3IG9wZW52c3dpdGNoIG5zaCBycGNyZG1hIGliX2lzZXIg
bGliaXNjc2kgc2NzaV90cmFuc3BvcnRfaXNjc2kgcmRtYV9jbSBpd19jbSBpYl9jbSBpYl9j
b3JlIHh0X2Nvbm50cmFjayB4dF9NQVNRVUVSQURFIG5mX2Nvbm50cmFja19uZXRsaW5rIG5m
bmV0bGluayB4dF9hZGRydHlwZSBpcHRhYmxlX25hdCBuZl9uYXQgYnJfbmV0ZmlsdGVyIG92
ZXJsYXkgZnVzZSBbbGFzdCB1bmxvYWRlZDogbWx4NF9jb3JlXQogWyAgNjc5LjQxMzMyM10g
Q1BVOiA0IFBJRDogMTgwNjQgQ29tbTogaWJ2X3hzcnFfcGluZ3BvIE5vdCB0YWludGVkIDUu
MTcuMC1yYzdfbWFzdGVyXzYyYzZlY2IgIzEKIFsgIDY3OS40MTUwNDNdIEhhcmR3YXJlIG5h
bWU6IFFFTVUgU3RhbmRhcmQgUEMgKFEzNSArIElDSDksIDIwMDkpLCBCSU9TIHJlbC0xLjEz
LjAtMC1nZjIxYjVhNGFlYjAyLXByZWJ1aWx0LnFlbXUub3JnIDA0LzAxLzIwMTQKIFsgIDY3
OS40MTcyODVdIFJJUDogMDAxMDptbHg0X2liX2RlYWxsb2NfeHJjZCsweDEyZS8weDFiMCBb
bWx4NF9pYl0KIFsgIDY3OS40MTg0NTVdIENvZGU6IDFlIDkzIDA4IDAwIDQwIDgwIGZkIDAx
IDBmIDg3IGZhIGYxIDA0IDAwIDgzIGU1IDAxIDBmIDg1IDJiIGZmIGZmIGZmIDQ4IGM3IGM3
IDIwIDRmIGI2IGEwIGM2IDA1IGZkIDkyIDA4IDAwIDAxIGU4IDQ3IGM5IDgyIGUyIDwwZj4g
MGIgZTkgMTEgZmYgZmYgZmYgMGYgYjYgMmQgZWIgOTIgMDggMDAgNDAgODAgZmQgMDEgMGYg
ODcgYjEgZjEKIFsgIDY3OS40MjE5OTNdIFJTUDogMDAxODpmZmZmODg4MWE0OTU3NzUwIEVG
TEFHUzogMDAwMTAyODYKIFsgIDY3OS40MjMwNDddIFJBWDogMDAwMDAwMDAwMDAwMDAwMCBS
Qlg6IGZmZmY4ODgxYWM0YjY4MDAgUkNYOiAwMDAwMDAwMDAwMDAwMDAwCiBbICA2NzkuNDI0
NDIwXSBSRFg6IDAwMDAwMDAwMDAwMDAwMjcgUlNJOiAwMDAwMDAwMDAwMDAwMDA0IFJESTog
ZmZmZmVkMTAzNDkyYWVkYwogWyAgNjc5LjQyNTgxOF0gUkJQOiAwMDAwMDAwMDAwMDAwMDAw
IFIwODogMDAwMDAwMDAwMDAwMDAwMSBSMDk6IGZmZmY4ODg0ZDJlMzc4ZWIKIFsgIDY3OS40
MjcxODZdIFIxMDogZmZmZmVkMTA5YTVjNmYxZCBSMTE6IDAwMDAwMDAwMDAwMDAwMDEgUjEy
OiBmZmZmODg4MTMyNjIwMDAwCiBbICA2NzkuNDI4NTUzXSBSMTM6IGZmZmY4ODgxYTQ5NTdh
OTAgUjE0OiBmZmZmODg4MWFhMmQ0MDAwIFIxNTogZmZmZjg4ODFhNDk1N2FkMAogWyAgNjc5
LjQyOTkzOV0gRlM6ICAwMDAwN2YwNDAxNzQ3NzQwKDAwMDApIEdTOmZmZmY4ODg0ZDJlMDAw
MDAoMDAwMCkga25sR1M6MDAwMDAwMDAwMDAwMDAwMAogWyAgNjc5LjQzMTU0OF0gQ1M6ICAw
MDEwIERTOiAwMDAwIEVTOiAwMDAwIENSMDogMDAwMDAwMDA4MDA1MDAzMwogWyAgNjc5LjQz
MjY5NV0gQ1IyOiAwMDAwNTVmOGFlMDM2MTE4IENSMzogMDAwMDAwMDEyZmU5NDAwNSBDUjQ6
IDAwMDAwMDAwMDAzNzBlYTAKIFsgIDY3OS40MzQwOTldIERSMDogMDAwMDAwMDAwMDAwMDAw
MCBEUjE6IDAwMDAwMDAwMDAwMDAwMDAgRFIyOiAwMDAwMDAwMDAwMDAwMDAwCiBbICA2Nzku
NDM1NDk4XSBEUjM6IDAwMDAwMDAwMDAwMDAwMDAgRFI2OiAwMDAwMDAwMGZmZmUwZmYwIERS
NzogMDAwMDAwMDAwMDAwMDQwMAogWyAgNjc5LjQzNjkxNF0gQ2FsbCBUcmFjZToKIFsgIDY3
OS40Mzc1MTBdICA8VEFTSz4KIFsgIDY3OS40MzgwNDJdICBpYl9kZWFsbG9jX3hyY2RfdXNl
cisweGNlLzB4MTIwIFtpYl9jb3JlXQogWyAgNjc5LjQzOTI0NV0gIGliX3V2ZXJic19kZWFs
bG9jX3hyY2QrMHhhZC8weDIxMCBbaWJfdXZlcmJzXQogWyAgNjc5LjQ0MDM4NV0gIHV2ZXJi
c19mcmVlX3hyY2QrMHhlOC8weDE5MCBbaWJfdXZlcmJzXQogWyAgNjc5LjQ0MTQ1M10gIGRl
c3Ryb3lfaHdfaWRyX3VvYmplY3QrMHg3YS8weDEzMCBbaWJfdXZlcmJzXQogWyAgNjc5LjQ0
MjU2OF0gIHV2ZXJic19kZXN0cm95X3VvYmplY3QrMHgxNjQvMHg3MzAgW2liX3V2ZXJic10K
IFsgIDY3OS40NDM2OTldICB1b2JqX2Rlc3Ryb3krMHg3Mi8weGYwIFtpYl91dmVyYnNdCiBb
ICA2NzkuNDQ0NjUzXSAgaWJfdXZlcmJzX2NtZF92ZXJicysweDE5ZmIvMHgzMTEwIFtpYl91
dmVyYnNdCiBbICA2NzkuNDQ1ODA1XSAgPyBlbnRyeV9TWVNDQUxMXzY0X2FmdGVyX2h3ZnJh
bWUrMHg0NC8weGFlCiBbICA2NzkuNDQ2ODkzXSAgPyB1dmVyYnNfZmluYWxpemVfb2JqZWN0
KzB4NTAvMHg1MCBbaWJfdXZlcmJzXQogWyAgNjc5LjQ0ODAzN10gID8gY2hlY2tfY2hhaW5f
a2V5KzB4MjRhLzB4NTgwCiBbICA2NzkuNDQ4OTE5XSAgPyB1dmVyYnNfZmlsbF91ZGF0YSsw
eDU0MC8weDU0MCBbaWJfdXZlcmJzXQogWyAgNjc5LjQ1MDA0MF0gID8gY2hlY2tfY2hhaW5f
a2V5KzB4MjRhLzB4NTgwCiBbICA2NzkuNDUwOTM0XSAgPyByZW1vdmVfdm1hKzB4Y2EvMHgx
MDAKIFsgIDY3OS40NTE3MzZdICA/IGxvY2tfYWNxdWlyZSsweDFiMS8weDRjMAogWyAgNjc5
LjQ1MjU1M10gID8gbG9ja19hY3F1aXJlKzB4MWIxLzB4NGMwCiBbICA2NzkuNDUzMzkzXSAg
PyBpYl91dmVyYnNfaW9jdGwrMHgxMWUvMHgyNjAgW2liX3V2ZXJic10KIFsgIDY3OS40NTQ0
MzhdICA/IF9fbWlnaHRfZmF1bHQrMHhiOC8weDE2MAogWyAgNjc5LjQ1NTI2N10gID8gbG9j
a2RlcF9oYXJkaXJxc19vbl9wcmVwYXJlKzB4NDAwLzB4NDAwCiBbICA2NzkuNDU2MzI5XSAg
aWJfdXZlcmJzX2lvY3RsKzB4MTY5LzB4MjYwIFtpYl91dmVyYnNdCiBbICA2NzkuNDU3Mzg0
XSAgPyBpYl91dmVyYnNfaW9jdGwrMHgxMWUvMHgyNjAgW2liX3V2ZXJic10KIFsgIDY3OS40
NTg0NDNdICA/IGliX3V2ZXJic19jbWRfdmVyYnMrMHgzMTEwLzB4MzExMCBbaWJfdXZlcmJz
XQogWyAgNjc5LjQ1OTU5OF0gID8gYXNtX3N5c3ZlY19hcGljX3RpbWVyX2ludGVycnVwdCsw
eDEyLzB4MjAKIFsgIDY3OS40NjA2ODldICA/IG1hcmtfaGVsZF9sb2NrcysweDlmLzB4ZTAK
IFsgIDY3OS40NjE1NzddICBfX3g2NF9zeXNfaW9jdGwrMHg4NTYvMHgxNTUwCiBbICA2Nzku
NDYyNDM5XSAgPyB2ZnNfZmlsZWF0dHJfc2V0KzB4OWYwLzB4OWYwCiBbICA2NzkuNDYzMzI4
XSAgPyBfX3VwX3JlYWQrMHgxYTMvMHg3NTAKIFsgIDY3OS40NjQxMDJdICA/IHVwX3dyaXRl
KzB4NGEwLzB4NGEwCiBbICA2NzkuNDY0ODY1XSAgPyBfX3ZtX211bm1hcCsweDIyZS8weDJl
MAogWyAgNjc5LjQ2NTY5MF0gID8gX194NjRfc3lzX2JyaysweDg0MC8weDg0MAogWyAgNjc5
LjQ2NjUxOV0gID8gX19jb25kX3Jlc2NoZWQrMHgxNy8weDgwCiBbICA2NzkuNDY3MzQwXSAg
PyBsb2NrZGVwX2hhcmRpcnFzX29uX3ByZXBhcmUrMHgyODYvMHg0MDAKIFsgIDY3OS40Njgz
NzNdICA/IHN5c2NhbGxfZW50ZXJfZnJvbV91c2VyX21vZGUrMHgxZC8weDUwCiBbICA2Nzku
NDY5NDExXSAgZG9fc3lzY2FsbF82NCsweDNkLzB4OTAKIFsgIDY3OS40NzAxNzRdICBlbnRy
eV9TWVNDQUxMXzY0X2FmdGVyX2h3ZnJhbWUrMHg0NC8weGFlCiBbICA2NzkuNDcxMTkxXSBS
SVA6IDAwMzM6MHg3ZjA0MDE5MTkxN2IKIFsgIDY3OS40NzE5NjFdIENvZGU6IDBmIDFlIGZh
IDQ4IDhiIDA1IDFkIGFkIDBjIDAwIDY0IGM3IDAwIDI2IDAwIDAwIDAwIDQ4IGM3IGMwIGZm
IGZmIGZmIGZmIGMzIDY2IDBmIDFmIDQ0IDAwIDAwIGYzIDBmIDFlIGZhIGI4IDEwIDAwIDAw
IDAwIDBmIDA1IDw0OD4gM2QgMDEgZjAgZmYgZmYgNzMgMDEgYzMgNDggOGIgMGQgZWQgYWMg
MGMgMDAgZjcgZDggNjQgODkgMDEgNDgKIFsgIDY3OS40NzU0NjddIFJTUDogMDAyYjowMDAw
N2ZmY2U3YzRhMDM4IEVGTEFHUzogMDAwMDAyNDYgT1JJR19SQVg6IDAwMDAwMDAwMDAwMDAw
MTAKIFsgIDY3OS40NzcwMTRdIFJBWDogZmZmZmZmZmZmZmZmZmZkYSBSQlg6IDAwMDA3ZmZj
ZTdjNGExNTggUkNYOiAwMDAwN2YwNDAxOTE5MTdiCiBbICA2NzkuNDc4NDM0XSBSRFg6IDAw
MDA3ZmZjZTdjNGExNDAgUlNJOiAwMDAwMDAwMGMwMTgxYjAxIFJESTogMDAwMDAwMDAwMDAw
MDAwMwogWyAgNjc5LjQ3OTg0MF0gUkJQOiAwMDAwN2ZmY2U3YzRhMTIwIFIwODogMDAwMDU1
ZjhhZTAyZDA4MCBSMDk6IDAwMDAwMDAwMDAwMDAwMDAKIFsgIDY3OS40ODEyMzFdIFIxMDog
MDAwMDAwMDAwMDAwMDAwMCBSMTE6IDAwMDAwMDAwMDAwMDAyNDYgUjEyOiAwMDAwN2ZmY2U3
YzRhMTIwCiBbICA2NzkuNDgyNjMwXSBSMTM6IDAwMDA3ZmZjZTdjNGExMTAgUjE0OiAwMDAw
NTVmOGFlMDJmNDQwIFIxNTogMDAwMDAwMDAwMDAwMDAwMAogWyAgNjc5LjQ4NDAwM10gIDwv
VEFTSz4KIFsgIDY3OS40ODQ1MzVdIGlycSBldmVudCBzdGFtcDogNjI3MTMKIFsgIDY3OS40
ODUzMTNdIGhhcmRpcnFzIGxhc3QgIGVuYWJsZWQgYXQgKDYyNzIzKTogWzxmZmZmZmZmZjgx
NDgwZjE3Pl0gX191cF9jb25zb2xlX3NlbSsweDY3LzB4NzAKIFsgIDY3OS40ODcwMTldIGhh
cmRpcnFzIGxhc3QgZGlzYWJsZWQgYXQgKDYyNzMwKTogWzxmZmZmZmZmZjgxNDgwZWZjPl0g
X191cF9jb25zb2xlX3NlbSsweDRjLzB4NzAKIFsgIDY3OS40ODg3MzRdIHNvZnRpcnFzIGxh
c3QgIGVuYWJsZWQgYXQgKDYyMjIwKTogWzxmZmZmZmZmZjgxMzU2NzlmPl0gX19pcnFfZXhp
dF9yY3UrMHgxMWYvMHgxNzAKIFsgIDY3OS40OTA1NjldIHNvZnRpcnFzIGxhc3QgZGlzYWJs
ZWQgYXQgKDYyMjE1KTogWzxmZmZmZmZmZjgxMzU2NzlmPl0gX19pcnFfZXhpdF9yY3UrMHgx
MWYvMHgxNzAKIFsgIDY3OS41MDMxNjhdIC0tLVsgZW5kIHRyYWNlIDAwMDAwMDAwMDAwMDAw
MDAgXS0tLQoKRml4ZXM6IDdjNGE1MzllYzM4ZiAoIlJETUEvY29yZTogRml4IGliX3FwX3Vz
ZWNudF9kZWMoKSBjYWxsZWQgd2hlbiBlcnJvciIpClJlcG9ydGVkLWJ5OiBMZW9uIFJvbWFu
b3Zza3kgPGxlb25yb0BudmlkaWEuY29tPgpTaWduZWQtb2ZmLWJ5OiBZYWp1biBEZW5nIDx5
YWp1bi5kZW5nQGxpbnV4LmRldj4KLS0tCiBkcml2ZXJzL2luZmluaWJhbmQvY29yZS92ZXJi
cy5jIHwgNCArKystCiAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAxIGRlbGV0
aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9pbmZpbmliYW5kL2NvcmUvdmVyYnMuYyBi
L2RyaXZlcnMvaW5maW5pYmFuZC9jb3JlL3ZlcmJzLmMKaW5kZXggYmM5YTgzZjFjYTJkLi4x
YjBmODcyYzZlZjMgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvaW5maW5pYmFuZC9jb3JlL3ZlcmJz
LmMKKysrIGIvZHJpdmVycy9pbmZpbmliYW5kL2NvcmUvdmVyYnMuYwpAQCAtMTE3OCw2ICsx
MTc4LDcgQEAgc3RhdGljIHN0cnVjdCBpYl9xcCAqY3JlYXRlX3hyY19xcF91c2VyKHN0cnVj
dCBpYl9xcCAqcXAsCiAJYXRvbWljX2luYygmcXBfaW5pdF9hdHRyLT54cmNkLT51c2VjbnQp
OwogCUlOSVRfTElTVF9IRUFEKCZxcC0+b3Blbl9saXN0KTsKIAorCWliX3FwX3VzZWNudF9p
bmMocXApOwogCXFwID0gX19pYl9vcGVuX3FwKHJlYWxfcXAsIHFwX2luaXRfYXR0ci0+ZXZl
bnRfaGFuZGxlciwKIAkJCSAgcXBfaW5pdF9hdHRyLT5xcF9jb250ZXh0KTsKIAlpZiAoSVNf
RVJSKHFwKSkKQEAgLTEyNDUsNyArMTI0Niw2IEBAIHN0YXRpYyBzdHJ1Y3QgaWJfcXAgKmNy
ZWF0ZV9xcChzdHJ1Y3QgaWJfZGV2aWNlICpkZXYsIHN0cnVjdCBpYl9wZCAqcGQsCiAJaWYg
KHJldCkKIAkJZ290byBlcnJfc2VjdXJpdHk7CiAKLQlpYl9xcF91c2VjbnRfaW5jKHFwKTsK
IAlyZG1hX3Jlc3RyYWNrX2FkZCgmcXAtPnJlcyk7CiAJcmV0dXJuIHFwOwogCkBAIC0xMzQ2
LDYgKzEzNDYsOCBAQCBzdHJ1Y3QgaWJfcXAgKmliX2NyZWF0ZV9xcF9rZXJuZWwoc3RydWN0
IGliX3BkICpwZCwKIAlpZiAoSVNfRVJSKHFwKSkKIAkJcmV0dXJuIHFwOwogCisJaWJfcXBf
dXNlY250X2luYyhxcCk7CisKIAlpZiAocXBfaW5pdF9hdHRyLT5jYXAubWF4X3JkbWFfY3R4
cykgewogCQlyZXQgPSByZG1hX3J3X2luaXRfbXJzKHFwLCBxcF9pbml0X2F0dHIpOwogCQlp
ZiAocmV0KQotLSAKMi4yNS4xCgo=

----=_RainLoop_652_197531094.1646892774--

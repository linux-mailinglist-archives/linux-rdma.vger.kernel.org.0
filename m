Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7D8916F47B
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Feb 2020 01:44:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729081AbgBZAol (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 25 Feb 2020 19:44:41 -0500
Received: from out20-50.mail.aliyun.com ([115.124.20.50]:56444 "EHLO
        out20-50.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728989AbgBZAol (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 25 Feb 2020 19:44:41 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07055607|-1;CH=green;DM=CONTINUE|CONTINUE|true|0.395781-0.00784535-0.596374;DS=CONTINUE|ham_system_inform|0.0246271-0.000720599-0.974652;FP=0|0|0|0|0|0|0|0;HT=e02c03312;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=4;RT=4;SR=0;TI=SMTPD_---.GsUQrkp_1582677876;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.GsUQrkp_1582677876)
          by smtp.aliyun-inc.com(10.147.41.187);
          Wed, 26 Feb 2020 08:44:36 +0800
Date:   Wed, 26 Feb 2020 08:44:39 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     Maor Gottlieb <maorg@mellanox.com>
Subject: Re: a bug(BUG: kernel NULL pointer dereference) of ib or mlx happened in 5.4.21 but not in 5.4.20
Cc:     Leon Romanovsky <leon@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-rdma <linux-rdma@vger.kernel.org>
In-Reply-To: <bc3ce212-9fde-0489-e7ac-8cb8be55c015@mellanox.com>
References: <20200221002631.97A1.409509F4@e16-tech.com> <bc3ce212-9fde-0489-e7ac-8cb8be55c015@mellanox.com>
Message-Id: <20200226084438.9265.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------_5E55BDEB000000009266_MULTIPART_MIXED_"
Content-Transfer-Encoding: 8bit
X-Mailer: Becky! ver. 2.74.03 [en]
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

--------_5E55BDEB000000009266_MULTIPART_MIXED_
Content-Type: text/plain; charset="GB2312"
Content-Transfer-Encoding: 8bit

Hi, Maor, Leon

The kernel 5.4.21 plus the two patches successfully boot now
without the NULL pointer problem. And nfs4/rdma sucessfully mount too.
#RDMA-core-Fix-use-of-logical-OR-in-get_new_pps.patch
#RDMA-core-fix-null.patch (the patch from Maor saved as git-am format)

My MCX354A have 2 port, and port 1 is set as InfiniBand, port 2 is set
as Ethernet.
# ibstat
CA 'mlx4_0'
        CA type: MT4099
        Number of ports: 2
        Firmware version: 2.42.5000
        Hardware version: 1
        Node GUID: 0xe41d2d03007b4080
        System image GUID: 0xe41d2d03007b4083
        Port 1:
                State: Down
                Physical state: Polling
                Rate: 10
                Base lid: 0
                LMC: 0
                SM lid: 0
                Capability mask: 0x02594868
                Port GUID: 0xe41d2d03007b4081
                Link layer: InfiniBand
        Port 2:
                State: Down
                Physical state: Disabled
                Rate: 40
                Base lid: 0
                LMC: 0
                SM lid: 0
                Capability mask: 0x00010000
                Port GUID: 0xe61d2dfffe7b4082
                Link layer: Ethernet

# mlxup
Querying Mellanox devices firmware ...

Device #1:
----------

  Device Type:      ConnectX3
  Part Number:      01T7NW
  Description:      ConnectX-3 VPI adapter; dual-port QSFP; FDR IB (56Gb/s) and 40GbE;PCIe3.0 x8 8GT/s; Dell PowerEdge
  PSID:             DEL1090001019
  PCI Device Name:  0000:84:00.0
  Port1 GUID:       e41d2d03007b4081
  Port2 MAC:        e41d2d7b4082
  Versions:         Current        Available
     FW             2.42.5000      N/A
     PXE            3.4.0752       N/A

  Status:           No matching image found


My server is a dell PowerEdge T630 with some other NIC cards.

# rxe_cfg
  Name        Link  Driver   Speed   NMTU  IPv4_addr      RDEV  RMTU
  em1         yes   igb              1500  192.168.2.63
  em2         no    igb              1500
  p1p1        no    bnx2x    10GigE  9000  10.0.0.63
  p1p2        no    bnx2x    10GigE  9000  10.0.1.63
  p6p2        no    mlx4_en          9000  10.40.1.63
  virbr0      no    bridge           1500  192.168.122.1
  virbr0-nic  no    tun              1500

Best Regards
王玉贵
2020/02/26

> On 2/20/2020 6:26 PM, Wang Yugui wrote:
> > Hi, Leon, Chuck
> >
> > It is still broken even with the hotfix(https://patchwork.kernel.org/patch/11387567/) for 5.4.21.
> 
> Hi Wang,
> 
> How can I reproduce it ?
> 
> Can you please try with the below diff?
> 
> iff --git a/drivers/infiniband/core/security.c b/drivers/infiniband/core/security.c
> index b9a36ea244d4..2d5608315dc8 100644
> --- a/drivers/infiniband/core/security.c
> +++ b/drivers/infiniband/core/security.c
> @@ -340,11 +340,15 @@ static struct ib_ports_pkeys *get_new_pps(const struct ib_qp *qp,
>  ??????????????? return NULL;
> 
>  ??????? if (qp_attr_mask & IB_QP_PORT)
> -?????????? new_pps->main.port_num =
> -?????????????????? (qp_pps) ? qp_pps->main.port_num : qp_attr->port_num;
> +???????? new_pps->main.port_num = qp_attr->port_num;
> + else if (qp_pps)
> +???????? new_pps->main.port_num = qp_pps->main.port_num;
> +
>  ??????? if (qp_attr_mask & IB_QP_PKEY_INDEX)
> -?????????? new_pps->main.pkey_index = (qp_pps) ? qp_pps->main.pkey_index :
> - qp_attr->pkey_index;
> +???????? new_pps->main.pkey_index = qp_attr->pkey_index;
> + else if (qp_pps)
> +???????? new_pps->main.pkey_index = qp_pps->main.pkey_index;
> +
>  ??????? if ((qp_attr_mask & IB_QP_PKEY_INDEX) && (qp_attr_mask & IB_QP_PORT))
>  ??????????????? new_pps->main.state = IB_PORT_PKEY_VALID;
> 
> >
> > the call stack is almost the same.
> >
> > Feb 20 23:49:53 T630 kernel: Call Trace:
> > Feb 20 23:49:53 T630 kernel: port_pkey_list_insert+0x30/0x1a0 [ib_core]
> > Feb 20 23:49:53 T630 kernel: ? kmem_cache_alloc_trace+0x219/0x230
> > Feb 20 23:49:53 T630 kernel: ib_security_modify_qp+0x244/0x3b0 [ib_core]
> > Feb 20 23:49:53 T630 kernel: _ib_modify_qp+0x1c0/0x3c0 [ib_core]
> > Feb 20 23:49:53 T630 kernel: ? dma_pool_free+0x24/0xc0
> > Feb 20 23:49:53 T630 kernel: ipoib_init_qp+0x77/0x190 [ib_ipoib]
> > Feb 20 23:49:53 T630 kernel: ? __mlx4_ib_query_pkey+0xe7/0x110 [mlx4_ib]
> > Feb 20 23:49:53 T630 kernel: ? ib_find_pkey+0x98/0xe0 [ib_core]
> > Feb 20 23:49:53 T630 kernel: ipoib_ib_dev_open_default+0x1a/0x180 [ib_ipoib]
> > Feb 20 23:49:53 T630 kernel: ipoib_ib_dev_open+0x66/0xa0 [ib_ipoib]
> > Feb 20 23:49:53 T630 kernel: ipoib_open+0x44/0x110 [ib_ipoib]
> > Feb 20 23:49:53 T630 kernel: __dev_open+0xcd/0x160
> > Feb 20 23:49:53 T630 kernel: __dev_change_flags+0x1ad/0x220
> > Feb 20 23:49:53 T630 kernel: ? __dev_notify_flags+0x95/0xf0
> > Feb 20 23:49:53 T630 kernel: dev_change_flags+0x21/0x60
> > Feb 20 23:49:53 T630 kernel: do_setlink+0x320/0xf00
> > Feb 20 23:49:53 T630 kernel: ? __nla_validate_parse+0x51/0x840
> > Feb 20 23:49:53 T630 kernel: ? xas_load+0x8/0x80
> > Feb 20 23:49:53 T630 kernel: ? __update_load_avg_cfs_rq+0x1d5/0x2c0
> > Feb 20 23:49:53 T630 kernel: ? cpumask_next+0x17/0x20
> > Feb 20 23:49:53 T630 kernel: ? __snmp6_fill_stats64.isra.56+0x6b/0x110
> > Feb 20 23:49:53 T630 kernel: ? __nla_validate_parse+0x51/0x840
> > Feb 20 23:49:53 T630 kernel: __rtnl_newlink+0x53d/0x890
> > Feb 20 23:49:53 T630 kernel: ? __nla_reserve+0x38/0x50
> > Feb 20 23:49:53 T630 kernel: ? __nla_put+0xc/0x20
> > Feb 20 23:49:53 T630 kernel: ? __nla_reserve+0x38/0x50
> > Feb 20 23:49:53 T630 kernel: ? __nla_put+0xc/0x20
> > Feb 20 23:49:53 T630 kernel: ? nla_put+0x2f/0x40
> > Feb 20 23:49:53 T630 kernel: ? __nla_reserve+0x38/0x50
> > Feb 20 23:49:53 T630 kernel: ? __nla_put+0xc/0x20
> > Feb 20 23:49:53 T630 kernel: ? nla_put+0x2f/0x40
> > Feb 20 23:49:53 T630 kernel: ? rt6_fill_node+0x2d4/0x850
> > Feb 20 23:49:53 T630 kernel: ? _cond_resched+0x15/0x30
> > Feb 20 23:49:53 T630 kernel: ? kmem_cache_alloc_trace+0x1c9/0x230
> > Feb 20 23:49:53 T630 kernel: rtnl_newlink+0x43/0x60
> > Feb 20 23:49:53 T630 kernel: rtnetlink_rcv_msg+0x2b1/0x360
> > Feb 20 23:49:53 T630 kernel: ? __kmalloc_node_track_caller+0x241/0x300
> > Feb 20 23:49:53 T630 kernel: ? _cond_resched+0x15/0x30
> > Feb 20 23:49:53 T630 kernel: ? rtnl_calcit.isra.32+0x110/0x110
> > Feb 20 23:49:53 T630 kernel: netlink_rcv_skb+0x49/0x110
> > Feb 20 23:49:53 T630 kernel: netlink_unicast+0x191/0x220
> > Feb 20 23:49:53 T630 kernel: netlink_sendmsg+0x21d/0x3f0
> > Feb 20 23:49:53 T630 kernel: sock_sendmsg+0x5b/0x60
> > Feb 20 23:49:53 T630 kernel: ____sys_sendmsg+0x1eb/0x260
> > Feb 20 23:49:53 T630 kernel: ? copy_msghdr_from_user+0xdb/0x160
> > Feb 20 23:49:53 T630 kernel: ___sys_sendmsg+0x7c/0xc0
> > Feb 20 23:49:53 T630 kernel: ? do_filp_open+0xa7/0x100
> > Feb 20 23:49:53 T630 kernel: ? netdev_run_todo+0x5e/0x290
> > Feb 20 23:49:53 T630 kernel: ? list_lru_add+0xb7/0x1d0
> > Feb 20 23:49:53 T630 kernel: __sys_sendmsg+0x57/0xa0
> > Feb 20 23:49:53 T630 kernel: do_syscall_64+0x5b/0x180
> > Feb 20 23:49:53 T630 kernel: entry_SYSCALL_64_after_hwframe+0x44/0xa9
> >
> >
> > This card have 2 port, and port 1 is set as InfiniBand, port 2
> > is set as Ethernet.
> >
> > # ibstat
> > CA 'mlx4_0'
> >          CA type: MT4099
> >          Number of ports: 2
> >          Firmware version: 2.42.5000
> >          Hardware version: 1
> >          Node GUID: 0xe41d2d03007b4080
> >          System image GUID: 0xe41d2d03007b4083
> >          Port 1:
> >                  State: Down
> >                  Physical state: Polling
> >                  Rate: 10
> >                  Base lid: 0
> >                  LMC: 0
> >                  SM lid: 0
> >                  Capability mask: 0x02594868
> >                  Port GUID: 0xe41d2d03007b4081
> >                  Link layer: InfiniBand
> >          Port 2:
> >                  State: Down
> >                  Physical state: Disabled
> >                  Rate: 40
> >                  Base lid: 0
> >                  LMC: 0
> >                  SM lid: 0
> >                  Capability mask: 0x00010000
> >                  Port GUID: 0xe61d2dfffe7b4082
> >                  Link layer: Ethernet
> >
> >
> > Best Regards
> > 王玉贵
> > 2020/02/21
> >
> >> On Thu, Feb 20, 2020 at 08:57:29AM -0500, Chuck Lever wrote:
> >>> Hello!
> >>>
> >>> Thanks for your bug report.
> >>>
> >>>
> >>>> On Feb 19, 2020, at 10:22 PM, Wang Yugui <wangyugui@e16-tech.com> wrote:
> >>>>
> >>>> Hi, chuck.lever
> >>>>
> >>>> a bug(BUG: kernel NULL pointer dereference) of ib or mlx happened in 5.4.21 but not in 5.4.20.
> >>>>
> >>>> maybe some releationship to xprtrdma-fix-dma-scatter-gather-list-mapping-imbalance.patch
> >>> I don't see an obvious connection to fix-dma-scatter-gather-list-mapping-imbalance.
> >>> The backtrace below is through IPoIB code paths. Those have nothing to do with
> >>> NFS/RDMA, which is the only ULP code that is changed by my commit.
> >>>
> >>>
> >>>> maybe the info is useful.
> >>> I'm copying linux-rdma for a bigger set of eyeballs.
> >>>
> >>> My knee-jerk recommendation is that if you have a reliable reproducer, try "git bisect"
> >>> between .20 and .21 to nail down a specific commit where the BUG starts to occur.
> >> No need to bisect, it is me who broke.
> >> The fix is already accepted, but not yet merged.
> >> https://patchwork.kernel.org/patch/11387567/
> >>
> >> Thanks
> > --------------------------------------
> > 北京京垓科技有限公司
> > 王玉贵	wangyugui@e16-tech.com
> > 电话：+86-136-71123776
> >

--------------------------------------
北京京垓科技有限公司
王玉贵	wangyugui@e16-tech.com
电话：+86-136-71123776

--------_5E55BDEB000000009266_MULTIPART_MIXED_
Content-Type: application/octet-stream;
 name="RDMA-core-fix-null.patch"
Content-Disposition: attachment;
 filename="RDMA-core-fix-null.patch"
Content-Transfer-Encoding: base64

RnJvbSBkNDA3OGI3YzVlOTc4MmIyY2EzZDZjNjAzNWY0YWJiOTk1YzRkYWI3IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBtYW9yZ0BtZWxsYW5veC5jb20KRGF0ZTogV2VkLCAyNiBGZWIg
MjAyMCAwNzo1ODoyOSArMDgwMApTdWJqZWN0OiBbUEFUQ0hdIFJETUEtY29yZS1maXgtTlVMTAoK
LS0tCiBkcml2ZXJzL2luZmluaWJhbmQvY29yZS9zZWN1cml0eS5jIHwgMTIgKysrKysrKystLS0t
CiAxIGZpbGUgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQoKZGlmZiAt
LWdpdCBhL2RyaXZlcnMvaW5maW5pYmFuZC9jb3JlL3NlY3VyaXR5LmMgYi9kcml2ZXJzL2luZmlu
aWJhbmQvY29yZS9zZWN1cml0eS5jCmluZGV4IDJiNGQ4MDMuLjllMjdjYTEgMTAwNjQ0Ci0tLSBh
L2RyaXZlcnMvaW5maW5pYmFuZC9jb3JlL3NlY3VyaXR5LmMKKysrIGIvZHJpdmVycy9pbmZpbmli
YW5kL2NvcmUvc2VjdXJpdHkuYwpAQCAtMzQwLDExICszNDAsMTUgQEAgc3RhdGljIHN0cnVjdCBp
Yl9wb3J0c19wa2V5cyAqZ2V0X25ld19wcHMoY29uc3Qgc3RydWN0IGliX3FwICpxcCwKIAkJcmV0
dXJuIE5VTEw7CiAKIAlpZiAocXBfYXR0cl9tYXNrICYgSUJfUVBfUE9SVCkKLQkJbmV3X3Bwcy0+
bWFpbi5wb3J0X251bSA9Ci0JCQkocXBfcHBzKSA/IHFwX3Bwcy0+bWFpbi5wb3J0X251bSA6IHFw
X2F0dHItPnBvcnRfbnVtOworCQluZXdfcHBzLT5tYWluLnBvcnRfbnVtID0gcXBfYXR0ci0+cG9y
dF9udW07CisJZWxzZSBpZiAocXBfcHBzKQorCQluZXdfcHBzLT5tYWluLnBvcnRfbnVtID0gcXBf
cHBzLT5tYWluLnBvcnRfbnVtOworCiAJaWYgKHFwX2F0dHJfbWFzayAmIElCX1FQX1BLRVlfSU5E
RVgpCi0JCW5ld19wcHMtPm1haW4ucGtleV9pbmRleCA9IChxcF9wcHMpID8gcXBfcHBzLT5tYWlu
LnBrZXlfaW5kZXggOgotCQkJCQkJICAgICAgcXBfYXR0ci0+cGtleV9pbmRleDsKKwkJbmV3X3Bw
cy0+bWFpbi5wa2V5X2luZGV4ID0gcXBfYXR0ci0+cGtleV9pbmRleDsKKwllbHNlIGlmIChxcF9w
cHMpCisJCW5ld19wcHMtPm1haW4ucGtleV9pbmRleCA9IHFwX3Bwcy0+bWFpbi5wa2V5X2luZGV4
OworCiAJaWYgKChxcF9hdHRyX21hc2sgJiBJQl9RUF9QS0VZX0lOREVYKSAmJiAocXBfYXR0cl9t
YXNrICYgSUJfUVBfUE9SVCkpCiAJCW5ld19wcHMtPm1haW4uc3RhdGUgPSBJQl9QT1JUX1BLRVlf
VkFMSUQ7CiAKLS0gCjIuMjQuMQoK
--------_5E55BDEB000000009266_MULTIPART_MIXED_
Content-Type: application/octet-stream;
 name="RDMA-core-Fix-use-of-logical-OR-in-get_new_pps.patch"
Content-Disposition: attachment;
 filename="RDMA-core-Fix-use-of-logical-OR-in-get_new_pps.patch"
Content-Transfer-Encoding: base64

RnJvbSBwYXRjaHdvcmsgTW9uIEZlYiAxNyAyMDo0MzoxOCAyMDIwCkNvbnRlbnQtVHlwZTogdGV4
dC9wbGFpbjsgY2hhcnNldD0idXRmLTgiCk1JTUUtVmVyc2lvbjogMS4wCkNvbnRlbnQtVHJhbnNm
ZXItRW5jb2Rpbmc6IDdiaXQKWC1QYXRjaHdvcmstU3VibWl0dGVyOiBOYXRoYW4gQ2hhbmNlbGxv
ciA8bmF0ZWNoYW5jZWxsb3JAZ21haWwuY29tPgpYLVBhdGNod29yay1JZDogMTEzODc1NjcKWC1Q
YXRjaHdvcmstRGVsZWdhdGU6IGpnZ0B6aWVwZS5jYQpSZXR1cm4tUGF0aDogPFNSUzA9ZUszQT00
Rj12Z2VyLmtlcm5lbC5vcmc9bGludXgtcmRtYS1vd25lckBrZXJuZWwub3JnPgpSZWNlaXZlZDog
ZnJvbSBtYWlsLmtlcm5lbC5vcmcgKHBkeC1rb3JnLW1haWwtMS53ZWIuY29kZWF1cm9yYS5vcmcK
IFsxNzIuMzAuMjAwLjEyM10pCglieSBwZHgta29yZy1wYXRjaHdvcmstMi53ZWIuY29kZWF1cm9y
YS5vcmcgKFBvc3RmaXgpIHdpdGggRVNNVFAgaWQgMUIyRTExNEUzCglmb3IgPHBhdGNod29yay1s
aW51eC1yZG1hQHBhdGNod29yay5rZXJuZWwub3JnPjsKIE1vbiwgMTcgRmViIDIwMjAgMjA6NDM6
NDAgKzAwMDAgKFVUQykKUmVjZWl2ZWQ6IGZyb20gdmdlci5rZXJuZWwub3JnICh2Z2VyLmtlcm5l
bC5vcmcgWzIwOS4xMzIuMTgwLjY3XSkKCWJ5IG1haWwua2VybmVsLm9yZyAoUG9zdGZpeCkgd2l0
aCBFU01UUCBpZCBFRjY0MTIwODAxCglmb3IgPHBhdGNod29yay1saW51eC1yZG1hQHBhdGNod29y
ay5rZXJuZWwub3JnPjsKIE1vbiwgMTcgRmViIDIwMjAgMjA6NDM6MzkgKzAwMDAgKFVUQykKQXV0
aGVudGljYXRpb24tUmVzdWx0czogbWFpbC5rZXJuZWwub3JnOwoJZGtpbT1wYXNzICgyMDQ4LWJp
dCBrZXkpIGhlYWRlci5kPWdtYWlsLmNvbSBoZWFkZXIuaT1AZ21haWwuY29tCiBoZWFkZXIuYj0i
TlNNMVA1U2IiClJlY2VpdmVkOiAobWFqb3Jkb21vQHZnZXIua2VybmVsLm9yZykgYnkgdmdlci5r
ZXJuZWwub3JnIHZpYSBsaXN0ZXhwYW5kCiAgICAgICAgaWQgUzE3Mjg2NzZBYmdCUVVuaiAoT1JD
UFQKICAgICAgICA8cmZjODIyO3BhdGNod29yay1saW51eC1yZG1hQHBhdGNod29yay5rZXJuZWwu
b3JnPik7CiAgICAgICAgTW9uLCAxNyBGZWIgMjAyMCAxNTo0MzozOSAtMDUwMApSZWNlaXZlZDog
ZnJvbSBtYWlsLW9pMS1mMTk0Lmdvb2dsZS5jb20gKFsyMDkuODUuMTY3LjE5NF06NDI0MjYgIkVI
TE8KICAgICAgICBtYWlsLW9pMS1mMTk0Lmdvb2dsZS5jb20iIHJob3N0LWZsYWdzLU9LLU9LLU9L
LU9LKSBieSB2Z2VyLmtlcm5lbC5vcmcKICAgICAgICB3aXRoIEVTTVRQIGlkIFMxNzI3MzAwQWJn
QlFVbmkgKE9SQ1BUCiAgICAgICAgPHJmYzgyMjtsaW51eC1yZG1hQHZnZXIua2VybmVsLm9yZz4p
OyBNb24sIDE3IEZlYiAyMDIwIDE1OjQzOjM4IC0wNTAwClJlY2VpdmVkOiBieSBtYWlsLW9pMS1m
MTk0Lmdvb2dsZS5jb20gd2l0aCBTTVRQIGlkIGoxMzJzbzE3OTM4NTE0b2loLjk7CiAgICAgICAg
TW9uLCAxNyBGZWIgMjAyMCAxMjo0MzozOCAtMDgwMCAoUFNUKQpES0lNLVNpZ25hdHVyZTogdj0x
OyBhPXJzYS1zaGEyNTY7IGM9cmVsYXhlZC9yZWxheGVkOwogICAgICAgIGQ9Z21haWwuY29tOyBz
PTIwMTYxMDI1OwogICAgICAgIGg9ZnJvbTp0bzpjYzpzdWJqZWN0OmRhdGU6bWVzc2FnZS1pZDpt
aW1lLXZlcnNpb24KICAgICAgICAgOmNvbnRlbnQtdHJhbnNmZXItZW5jb2Rpbmc7CiAgICAgICAg
Ymg9bXQ4S0VpSFZGWHQrVkk3b3lhUlRvWWFFeEdVUGljd2JmSTRqNnd3dFBRRT07CiAgICAgICAg
Yj1OU00xUDVTYmpocERCUTlWOUkrN0pLS05aWjhYc2kvQW8vZ09VYlExeGQrM0ZDU3ZaQmlLMmYy
OGpQdzhHTHhBRWkKICAgICAgICAgYVBaZWhweHZ1ZE1raWRVcmNHc0IyQmV3MU00amI3cXdkN0NV
NktTdXRlV1ZFTHlibVFxcW4rc1dkVHVpR2pSYTJnMTAKICAgICAgICAgK1hQckN5N0lmenh1aVlY
eEpHTm43TXM3d3RMcHBvL051WE9PTFFnRFhMcGN4RlU0U0JGRG9JY0pKeklzNk1yWnB0NXYKICAg
ICAgICAgT0s5V3BxNHZpQ2p4VXJ4QXF2UmgvVzJWSGR4bFMvTThaYWhiS0RYSC9VMmdKUTVpVHR5
emFUcXFpc1lib0VKeGp0VmwKICAgICAgICAgaE5IYkZ5SWFOQmtHeThZN2dXYWNWVm8wK1g3N2gw
NkRhRWkwSElacndIM21HMjYwamhoNFBZVE04K2NKWldnWGlrbWkKICAgICAgICAgYllBZz09Clgt
R29vZ2xlLURLSU0tU2lnbmF0dXJlOiB2PTE7IGE9cnNhLXNoYTI1NjsgYz1yZWxheGVkL3JlbGF4
ZWQ7CiAgICAgICAgZD0xZTEwMC5uZXQ7IHM9MjAxNjEwMjU7CiAgICAgICAgaD14LWdtLW1lc3Nh
Z2Utc3RhdGU6ZnJvbTp0bzpjYzpzdWJqZWN0OmRhdGU6bWVzc2FnZS1pZDptaW1lLXZlcnNpb24K
ICAgICAgICAgOmNvbnRlbnQtdHJhbnNmZXItZW5jb2Rpbmc7CiAgICAgICAgYmg9bXQ4S0VpSFZG
WHQrVkk3b3lhUlRvWWFFeEdVUGljd2JmSTRqNnd3dFBRRT07CiAgICAgICAgYj1uSHhKYi9OMGFF
WEkxTkx1RVg2djdnb01SS0xxU3kyL2Y2T2UvdXI0R0RuUXVKVVd2MUozKzhZOWhqbXZtVGZmR2QK
ICAgICAgICAgaERVTFpvZU1EZjBaSThsTmpYR2o1bUdjUWpnbTREUENmQ1U1bEh0U0dDenRtRzlK
NjdVQUkyYmxHVVBSYTk5bjhYOGgKICAgICAgICAgaEFLNkZTUkVZL21vb0EwVjJEMnd3MXJ5LzY4
MDBDWkk1T0JCTGhFM3hTcDhuZDM4WVQ5U2NvNmJCS21rcUQ4UnFGMVgKICAgICAgICAgVFEzSm1S
R3RIZUJBTGdMbTVDd2xyMUt0QjZpMzVOSHlNbEhOaGR3UFNLRHZaR3ZqVHF3NFlGUkhpU0lYMTZL
NWE5QWcKICAgICAgICAgQXhydzVUT1R5aWNvVng3ajBBbVBCUUkxdmVDS3ZvVlNDN3RDalkyUUVF
TjFLNFJqS3lBVmhaMTU0aURPYW5YQXduZTQKICAgICAgICAgUmlFQT09ClgtR20tTWVzc2FnZS1T
dGF0ZTogQVBqQUFBV3g4eE5zbURINVNuaWFTbGFTNmdLSTBjTU5EbmI2cWZia2djc1FvbTRjREk1
UlJISUgKICAgICAgICBYaW9Oa0lxOERrN1lzaVNuTmluK2F6az0KWC1Hb29nbGUtU210cC1Tb3Vy
Y2U6IAogQVBYdllxd1NjRXU0RDdLZUNZcU84LzF2OUtkV2s1R1NZTnR5cGRreE5VZnFCSGVjZjBL
amV3d0FQWHNtVWwwVWoxQVpVb3ErSjRNQWNBPT0KWC1SZWNlaXZlZDogYnkgMjAwMjphY2E6NTMw
ZTo6IHdpdGggU01UUCBpZCBoMTRtcjUwNTcxMm9pYi4xMDUuMTU4MTk3MjIxODA5MjsKICAgICAg
ICBNb24sIDE3IEZlYiAyMDIwIDEyOjQzOjM4IC0wODAwIChQU1QpClJlY2VpdmVkOiBmcm9tIGxv
Y2FsaG9zdC5sb2NhbGRvbWFpbiAoWzI2MDQ6MTM4MDo0MTExOjhiMDA6OjFdKQogICAgICAgIGJ5
IHNtdHAuZ21haWwuY29tIHdpdGggRVNNVFBTQSBpZAogdzIwc201NDU1OTJvdGouMjEuMjAyMC4w
Mi4xNy4xMi40My4zNwogICAgICAgICh2ZXJzaW9uPVRMUzFfMyBjaXBoZXI9VExTX0FFU18yNTZf
R0NNX1NIQTM4NCBiaXRzPTI1Ni8yNTYpOwogICAgICAgIE1vbiwgMTcgRmViIDIwMjAgMTI6NDM6
MzcgLTA4MDAgKFBTVCkKRnJvbTogTmF0aGFuIENoYW5jZWxsb3IgPG5hdGVjaGFuY2VsbG9yQGdt
YWlsLmNvbT4KVG86IERvdWcgTGVkZm9yZCA8ZGxlZGZvcmRAcmVkaGF0LmNvbT4sIEphc29uIEd1
bnRob3JwZSA8amdnQHppZXBlLmNhPgpDYzogTGVvbiBSb21hbm92c2t5IDxsZW9uQGtlcm5lbC5v
cmc+LCBsaW51eC1yZG1hQHZnZXIua2VybmVsLm9yZywKICAgICAgICBsaW51eC1rZXJuZWxAdmdl
ci5rZXJuZWwub3JnLCBjbGFuZy1idWlsdC1saW51eEBnb29nbGVncm91cHMuY29tLAogICAgICAg
IE5hdGhhbiBDaGFuY2VsbG9yIDxuYXRlY2hhbmNlbGxvckBnbWFpbC5jb20+ClN1YmplY3Q6IFtQ
QVRDSF0gUkRNQS9jb3JlOiBGaXggdXNlIG9mIGxvZ2ljYWwgT1IgaW4gZ2V0X25ld19wcHMKRGF0
ZTogTW9uLCAxNyBGZWIgMjAyMCAxMzo0MzoxOCAtMDcwMApNZXNzYWdlLUlkOiA8MjAyMDAyMTcy
MDQzMTguMTM2MDktMS1uYXRlY2hhbmNlbGxvckBnbWFpbC5jb20+ClgtTWFpbGVyOiBnaXQtc2Vu
ZC1lbWFpbCAyLjI1LjEKTUlNRS1WZXJzaW9uOiAxLjAKWC1QYXRjaHdvcmstQm90OiBub3RpZnkK
U2VuZGVyOiBsaW51eC1yZG1hLW93bmVyQHZnZXIua2VybmVsLm9yZwpQcmVjZWRlbmNlOiBidWxr
Ckxpc3QtSUQ6IDxsaW51eC1yZG1hLnZnZXIua2VybmVsLm9yZz4KWC1NYWlsaW5nLUxpc3Q6IGxp
bnV4LXJkbWFAdmdlci5rZXJuZWwub3JnCgpDbGFuZyB3YXJuczoKCi4uL2RyaXZlcnMvaW5maW5p
YmFuZC9jb3JlL3NlY3VyaXR5LmM6MzUxOjQxOiB3YXJuaW5nOiBjb252ZXJ0aW5nIHRoZQplbnVt
IGNvbnN0YW50IHRvIGEgYm9vbGVhbiBbLVdpbnQtaW4tYm9vbC1jb250ZXh0XQogICAgICAgIGlm
ICghKHFwX2F0dHJfbWFzayAmIChJQl9RUF9QS0VZX0lOREVYIHx8IElCX1FQX1BPUlQpKSAmJiBx
cF9wcHMpIHsKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBe
CjEgd2FybmluZyBnZW5lcmF0ZWQuCgpBIGJpdHdpc2UgT1Igc2hvdWxkIGhhdmUgYmVlbiB1c2Vk
IGluc3RlYWQuCgpGaXhlczogMWRkMDE3ODgyZTAxICgiUkRNQS9jb3JlOiBGaXggcHJvdGVjdGlv
biBmYXVsdCBpbiBnZXRfcGtleV9pZHhfcXBfbGlzdCIpCkxpbms6IGh0dHBzOi8vZ2l0aHViLmNv
bS9DbGFuZ0J1aWx0TGludXgvbGludXgvaXNzdWVzLzg4OQpTaWduZWQtb2ZmLWJ5OiBOYXRoYW4g
Q2hhbmNlbGxvciA8bmF0ZWNoYW5jZWxsb3JAZ21haWwuY29tPgpSZXZpZXdlZC1ieTogTGVvbiBS
b21hbm92c2t5IDxsZW9ucm9AbWVsbGFub3guY29tPgotLS0KIGRyaXZlcnMvaW5maW5pYmFuZC9j
b3JlL3NlY3VyaXR5LmMgfCAyICstCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEg
ZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2luZmluaWJhbmQvY29yZS9zZWN1cml0
eS5jIGIvZHJpdmVycy9pbmZpbmliYW5kL2NvcmUvc2VjdXJpdHkuYwppbmRleCAyYjRkODAzOTNi
ZDAuLmI5YTM2ZWEyNDRkNCAxMDA2NDQKLS0tIGEvZHJpdmVycy9pbmZpbmliYW5kL2NvcmUvc2Vj
dXJpdHkuYworKysgYi9kcml2ZXJzL2luZmluaWJhbmQvY29yZS9zZWN1cml0eS5jCkBAIC0zNDgs
NyArMzQ4LDcgQEAgc3RhdGljIHN0cnVjdCBpYl9wb3J0c19wa2V5cyAqZ2V0X25ld19wcHMoY29u
c3Qgc3RydWN0IGliX3FwICpxcCwKIAlpZiAoKHFwX2F0dHJfbWFzayAmIElCX1FQX1BLRVlfSU5E
RVgpICYmIChxcF9hdHRyX21hc2sgJiBJQl9RUF9QT1JUKSkKIAkJbmV3X3Bwcy0+bWFpbi5zdGF0
ZSA9IElCX1BPUlRfUEtFWV9WQUxJRDsKIAotCWlmICghKHFwX2F0dHJfbWFzayAmIChJQl9RUF9Q
S0VZX0lOREVYIHx8IElCX1FQX1BPUlQpKSAmJiBxcF9wcHMpIHsKKwlpZiAoIShxcF9hdHRyX21h
c2sgJiAoSUJfUVBfUEtFWV9JTkRFWCB8IElCX1FQX1BPUlQpKSAmJiBxcF9wcHMpIHsKIAkJbmV3
X3Bwcy0+bWFpbi5wb3J0X251bSA9IHFwX3Bwcy0+bWFpbi5wb3J0X251bTsKIAkJbmV3X3Bwcy0+
bWFpbi5wa2V5X2luZGV4ID0gcXBfcHBzLT5tYWluLnBrZXlfaW5kZXg7CiAJCWlmIChxcF9wcHMt
Pm1haW4uc3RhdGUgIT0gSUJfUE9SVF9QS0VZX05PVF9WQUxJRCkK
--------_5E55BDEB000000009266_MULTIPART_MIXED_--


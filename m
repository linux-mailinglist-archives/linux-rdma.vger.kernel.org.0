Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC5F9646CD
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jul 2019 15:08:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726184AbfGJNIY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 10 Jul 2019 09:08:24 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:52727 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbfGJNIY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 10 Jul 2019 09:08:24 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MT9zD-1hvHLv1pVf-00UWdp; Wed, 10 Jul 2019 15:08:04 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Kamenee Arumugam <kamenee.arumugam@intel.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Shamir Rabinovitch <shamir.rabinovitch@oracle.com>,
        Gal Pressman <galpress@amazon.com>,
        Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: [PATCH] [net-next] IB/hfi1: removed shadowed 'err' variable
Date:   Wed, 10 Jul 2019 15:07:51 +0200
Message-Id: <20190710130802.1878874-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:KkQQx8DbdUAeEoiZ4dYi+5NkNEKv2SgbU+HJttadWoj6WJJyCL6
 sIVYpTHXvGhQ/eSTFB5EwdD+YKjqIhJKH2Tw4C7ZvviaK3SfFYkw5tF8WohilXIz6SjQ42U
 TlAyZSlmLeQ919CjlfeUBjm68ud+/2t2B8L+h8ACU+efARBFY2lVb+VA9jOM4t6swldiVW6
 RH66axC5tDxrPc5gl30Gw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:zECRC6kMYdA=:9tSX5Ea1rKb7S91ddPQyVz
 gg/zpmly8nKnhW6vo+Tzvx62YfsMqTTNtQbjXn3lnxe7mnfGB94kmQ9QjpStn9EAuFL0U2e8+
 O9qsKHjbM9caD/MoH6rwA1knKrwTrBizT2cd+86qkN65zaXcFMFnt80BeInYyND4Lqss3kQtZ
 0xqbZvv/hhT3Vao1zVLwlag/DEdiZDdK8rPhNuLP199HCu4+1H1UlstaZpcRnIlw32qx0uLy7
 kRMfQsJjclztQ4C7cob9ksh95ZqiXKfaCCE/Y/zfiFUP6mIzGpl66oHjQk8LXZvsXgRWj3zAb
 hLTm0nwW1OOi4vRqf/JhhQH3PVNVnRQYlOdLg36ynXSgaAgvbR0TbpJDglSwnaQf3W/vs+B5o
 ZLMRjDzZvlY4Uc0c3Ln3Md76EctKxwa4OuqZ6hRxHBumL+Nscu88XPZfh7aBdDG5D5btUGZfe
 8W812KGMYFXclNdPApk9DsS1gfPoZdRQGa9e7Wl7NdQom55Nugj6/qOFlG6ttBwgGCfJcOeZ7
 ZlcLPp53zzCfS0ZgPy0uPn8PMyNnraOkWp41XI8C31PqNAY67eDy1LhGCSnX91YfzsOJUfiY2
 YtUyhwYXmxRCyINLWEm/j5kqVNNPYi4Is6ndt0kVcbeqKkTom/OwxPPxpJ37IvIVI61ykF030
 0UK6Ce/PPFBrEM+xKEhXduLZTkhWUsbyT0Qq22mJU2NIOWKN5sulHle8xCeaJFslBQ5/gUPNb
 RxlvgFgvrrPGiD19ERpHdXshpvTFaaM7/M6J9Q==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

As clang reports, rvt_create_cq() may return an uninitialized
variable, because the 'err' variable is shadowed by another
local declaration:

drivers/infiniband/sw/rdmavt/cq.c:260:7: warning: variable 'err' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
                if (err)
                    ^~~
drivers/infiniband/sw/rdmavt/cq.c:310:9: note: uninitialized use occurs here
        return err;
               ^~~
drivers/infiniband/sw/rdmavt/cq.c:260:3: note: remove the 'if' if its condition is always false
                if (err)
                ^~~~~~~~
drivers/infiniband/sw/rdmavt/cq.c:253:7: warning: variable 'err' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
                if (!cq->ip) {
                    ^~~~~~~
drivers/infiniband/sw/rdmavt/cq.c:310:9: note: uninitialized use occurs here
        return err;
               ^~~
drivers/infiniband/sw/rdmavt/cq.c:253:3: note: remove the 'if' if its condition is always false
                if (!cq->ip) {
                ^~~~~~~~~~~~~~
drivers/infiniband/sw/rdmavt/cq.c:211:9: note: initialize the variable 'err' to silence this warning
        int err;
               ^
                = 0

I can't think of any reason for the inner variable declaration, so
remove it to avoid the issue.

Fixes: 239b0e52d8aa ("IB/hfi1: Move rvt_cq_wc struct into uapi directory")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/infiniband/sw/rdmavt/cq.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/infiniband/sw/rdmavt/cq.c b/drivers/infiniband/sw/rdmavt/cq.c
index fac87b13329d..a85571a4cf57 100644
--- a/drivers/infiniband/sw/rdmavt/cq.c
+++ b/drivers/infiniband/sw/rdmavt/cq.c
@@ -247,8 +247,6 @@ int rvt_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 	 * See rvt_mmap() for details.
 	 */
 	if (udata && udata->outlen >= sizeof(__u64)) {
-		int err;
-
 		cq->ip = rvt_create_mmap_info(rdi, sz, udata, u_wc);
 		if (!cq->ip) {
 			err = -ENOMEM;
-- 
2.20.0


Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ABAF812A694
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Dec 2019 08:24:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725935AbfLYHYF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 25 Dec 2019 02:24:05 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:33035 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbfLYHYF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 25 Dec 2019 02:24:05 -0500
Received: by mail-lf1-f66.google.com with SMTP id n25so16462746lfl.0
        for <linux-rdma@vger.kernel.org>; Tue, 24 Dec 2019 23:24:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HAdwo+pus8eROgK5J/AkA5BfnS0YXt46QyvukYfmD/I=;
        b=uGo/veNqL1GW7MbrHiev91W2r7aO64CMANWmD+LXauXCksjOjExeIM+61Afzuz52wT
         KVNx5dVHyzV5PTtXBoXUKQUW6ZkA790EwienrlNfYMs53soBXOrD00IgJtP6isdx5HzU
         tJVlon2LBQODPRTgYFPsReykIVm3Bhe13kPaKfp7teHjJAWeaq1mytFex1jSaofHrARh
         lN0DJ7X/wrIQZ3862kfovkaB860rzyPYT6gRDZRqOgLeM4CAtpDZe4zoCCeOlhLdCJVq
         tzvCD/mxu5/YRs0cyL8/EdwwSFLnj5cHBxN87oJ8tVE0bjd3P0poVroTf/bhcnl5lLBS
         eAIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HAdwo+pus8eROgK5J/AkA5BfnS0YXt46QyvukYfmD/I=;
        b=Lkv28Ndz/xrUAZW1vMp1MAi74+l/HKaEifwWDhyISbfnPfDNxBavQAwLcwrWET/Qlz
         Pe4dCACwY7M1YlHY0ux0kyZZrqy+KMyhwjJ8OiVBMNlydZ9FxrpXmj2rQKSpzb6dUb5u
         JHm2BpMedSFLRy+SVT4ZAfERxgKIEw+JsJPjT5a9trGUz7xTADokV8JHX61w0dRCdWp4
         fqD8mtVemM7SG7PfhCa2xK1xvbj/oLLGyP8MC0ARItdITJE850T33w6F5ZD0xC2VK/C4
         T14q7ksfs8erFw82YxCJhRZFPOQeZ+SkGgpFF9nxLEzwd6RTYkvtAyYhds5KIth/X0K+
         pllw==
X-Gm-Message-State: APjAAAW23FN6l110Zf9w2K6hGKZYAYtTspcjiU8brdwkUqZthFdNrSST
        CEuNkgpnG38/V3nVNDM0qMwN2Y5gEp1QY5EiTKiZfw/no+9j0A==
X-Google-Smtp-Source: APXvYqwuw33roiHxsibJzIoooqil01TvYqplSeAH+RJD3lcGwMehPyuaKJEcEvvKdgKZFYn9/cu5n9eVdA8Hm7W7gnw=
X-Received: by 2002:a19:c3cc:: with SMTP id t195mr22878899lff.144.1577258643201;
 Tue, 24 Dec 2019 23:24:03 -0800 (PST)
MIME-Version: 1.0
References: <CAKC_zSs=m_qPs06ZqxB-UJ_nHqhb+V2CBNKj3HsdJX+6eevqCA@mail.gmail.com>
 <20191225063256.GB212002@unreal>
In-Reply-To: <20191225063256.GB212002@unreal>
From:   Frank Huang <tigerinxm@gmail.com>
Date:   Wed, 25 Dec 2019 15:23:53 +0800
Message-ID: <CAKC_zSts5zdbM4LhUaPBWk8=uKGAKWX6vgd85cdKjOrZViiEJg@mail.gmail.com>
Subject: Re: rxe panic
To:     Leon Romanovsky <leon@kernel.org>
Cc:     linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

hi leon

I can not get what you means, do you say the rxe_add_ref(qp) is not needed?
My kernel is old, and I found some bugs of rxe on 4.14.97, especially
the rnr errors.
I can not upgrade whole kernel because there are many dependencies.
Finally , I sync the fixed from newest kernel version to the 4.14.97.

When I compare my rxe_resp.c with kernel 5.2.9 , I found the snippet
of duplicate_request is changed.
and rxe_xmit_packet will call rxe_send=EF=BC=8Center the log "rdma_rxe:
Unknown layer 3 protocol: 0"

  1137 } else {
  1138 struct resp_res *res;
  1139
  1140 /* Find the operation in our list of responder resources. */
  1141 res =3D find_resource(qp, pkt->psn);
  1142 if (res) {
  1143 struct sk_buff *skb_copy;
  1144
  1145 skb_copy =3D skb_clone(res->atomic.skb, GFP_ATOMIC);
  1146 if (skb_copy) {
  1147 rxe_add_ref(qp); /* for the new SKB */
  1148 } else {
  1149 pr_warn("Couldn't clone atomic resp\n");
  1150 rc =3D RESPST_CLEANUP;
  1151 goto out;
  1152 }
  1153
  1154 /* Resend the result. */
  1155 rc =3D rxe_xmit_packet(to_rdev(qp->ibqp.device), qp,
  1156      pkt, skb_copy);
  1157 if (rc) {
  1158 pr_err("Failed resending result. This flow is not handled - skb
ignored\n");
  1159 rxe_drop_ref(qp);
  1160 rc =3D RESPST_CLEANUP;
  1161 goto out;
  1162 }
  1163 }
  1164
  1165 /* Resource not found. Class D error. Drop the request. */
  1166 rc =3D RESPST_CLEANUP;
  1167 goto out;
  1168 }
  1169 out:
  1170 return rc;
  1171 }

On Wed, Dec 25, 2019 at 2:33 PM Leon Romanovsky <leon@kernel.org> wrote:
>
> On Wed, Dec 25, 2019 at 12:55:35PM +0800, Frank Huang wrote:
> > hi, there is a panic on rdma_rxe module when the restart
> > network.service or shutdown the switch.
> >
> > it looks like a use-after-free error.
> >
> > everytime it happens, there is the log "rdma_rxe: Unknown layer 3 proto=
col: 0"
>
> The error print itself is harmless.
> >
> > is it a known error?
> >
> > my kernel version is 4.14.97
>
> Your kernel is old enough and doesn't include refcount,
> so I can't say for sure that it is the case, but the
> following code is not correct and with refcount debug
> it will be seen immediately.
>
> 1213 int rxe_responder(void *arg)
> 1214 {
> 1215         struct rxe_qp *qp =3D (struct rxe_qp *)arg;
> 1216         struct rxe_dev *rxe =3D to_rdev(qp->ibqp.device);
> 1217         enum resp_states state;
> 1218         struct rxe_pkt_info *pkt =3D NULL;
> 1219         int ret =3D 0;
> 1220
> 1221         rxe_add_ref(qp); <------ USE-AFTER-FREE
> 1222
> 1223         qp->resp.aeth_syndrome =3D AETH_ACK_UNLIMITED;
> 1224
> 1225         if (!qp->valid) {
> 1226                 ret =3D -EINVAL;
> 1227                 goto done;
> 1228         }
>
> Thanks

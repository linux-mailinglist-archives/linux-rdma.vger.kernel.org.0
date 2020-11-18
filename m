Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5CB32B760B
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Nov 2020 06:52:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725772AbgKRFuD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 18 Nov 2020 00:50:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbgKRFuD (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 18 Nov 2020 00:50:03 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B18EC0613D4
        for <linux-rdma@vger.kernel.org>; Tue, 17 Nov 2020 21:50:03 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id d9so758786qke.8
        for <linux-rdma@vger.kernel.org>; Tue, 17 Nov 2020 21:50:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CmF8VKCkLQuDHAfOjp18zI6Qqdx49D746KVQb+RtQW4=;
        b=YrJSHJE4aEw4gTPE3eHUgd5B7GTxNQXU3olt/XIG/x05+MFlio/IdQydfqmszW/n7L
         UnxvpUcAz7kg0GZ/Hq3NnTsSbEXYDvlf0iBZaWpSLqRe2db32p2kTlbsAsth7UnfiiA2
         InWRE3Z0NjP/kBXp7Y+rQ2X9b8CR3jEpvDESw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CmF8VKCkLQuDHAfOjp18zI6Qqdx49D746KVQb+RtQW4=;
        b=thZF4PJknTfE+mJdfCmVI8+xWZuNN9AgnTvQ+tVkSOtyVmLtf+bMCS42jJCPt3t9P0
         702EL0747Kf3B9LTb3v40jTsUOvsmqdVWd5hI2bhcKvO4FJwkAU+uQDV/HE+U6NlPEa0
         6SAyDNe1GjH96wthN2aqrcMW3LQ5Zz5+3/sZCx2Xtx/BaMZwQDhHUQnLQ6yBSrtkYu6q
         bPYO//aYp1oQqOHSjdn9UJWRavm0iVGxL98tzq550kIXA/NkL6GitABiO6Mk0sttgKb1
         +uB3DR90t3PnIWRQQFvArAA6UYdL5ZOWiylpPxYGkzhY+QE3F868h35eeNwIMObMzPWl
         ID7Q==
X-Gm-Message-State: AOAM531ojcpwkZtl0k8Pnh9HycD8PyY/KYoMqlhVsMZiu46iBaGNcHtw
        5eLT40OF9+6MY/jabhtCXfShKcHH4vA9Iq1dndJoyg==
X-Google-Smtp-Source: ABdhPJwz2/aPqHze3IQa6N22TWCCJPGDlRV2GWLqEiC77NARYt5rzqNWeF0MgJTR12pdsfEgjhUEGfVpo8B0TbqAvLk=
X-Received: by 2002:a37:b782:: with SMTP id h124mr3350074qkf.169.1605678601995;
 Tue, 17 Nov 2020 21:50:01 -0800 (PST)
MIME-Version: 1.0
References: <20201113081534.GA50833@mwanda>
In-Reply-To: <20201113081534.GA50833@mwanda>
From:   Devesh Sharma <devesh.sharma@broadcom.com>
Date:   Wed, 18 Nov 2020 11:19:25 +0530
Message-ID: <CANjDDBg3X1SVt4-tOMX4Z8A3rdKfOVGKRJeesEwr9-UjEbs6mQ@mail.gmail.com>
Subject: Re: [bug report] RDMA/bnxt_re: Fix broken RoCE driver due to recent
 L2 driver changes
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     linux-rdma <linux-rdma@vger.kernel.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000bcbeda05b45b2e06"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

--000000000000bcbeda05b45b2e06
Content-Type: text/plain; charset="UTF-8"

On Fri, Nov 13, 2020 at 1:45 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> Hello Devesh Sharma,
>
> The patch 6e04b1035689: "RDMA/bnxt_re: Fix broken RoCE driver due to
> recent L2 driver changes" from May 25, 2018, leads to the following
> static checker warning:
>
>         drivers/infiniband/hw/bnxt_re/qplib_fp.c:471 bnxt_qplib_nq_start_irq()
>         warn: 'nq->msix_vec' not released on lines: 471.
>
> drivers/infiniband/hw/bnxt_re/qplib_fp.c
>    441  int bnxt_qplib_nq_start_irq(struct bnxt_qplib_nq *nq, int nq_indx,
>    442                              int msix_vector, bool need_init)
>    443  {
>    444          int rc;
>    445
>    446          if (nq->requested)
>    447                  return -EFAULT;
>    448
>    449          nq->msix_vec = msix_vector;
>    450          if (need_init)
>    451                  tasklet_setup(&nq->nq_tasklet, bnxt_qplib_service_nq);
>    452          else
>    453                  tasklet_enable(&nq->nq_tasklet);
>    454
>    455          snprintf(nq->name, sizeof(nq->name), "bnxt_qplib_nq-%d", nq_indx);
>    456          rc = request_irq(nq->msix_vec, bnxt_qplib_nq_irq, 0, nq->name, nq);
>    457          if (rc)
>    458                  return rc;
>    459
>    460          cpumask_clear(&nq->mask);
>    461          cpumask_set_cpu(nq_indx, &nq->mask);
>    462          rc = irq_set_affinity_hint(nq->msix_vec, &nq->mask);
>    463          if (rc) {
>    464                  dev_warn(&nq->pdev->dev,
>    465                           "set affinity failed; vector: %d nq_idx: %d\n",
>    466                           nq->msix_vec, nq_indx);
>
> Say irq_set_affinity_hint() fails then should we call release_irq()?
No, the driver wants to treat it as a soft error and just flash a debug message.
>
>    467          }
>    468          nq->requested = true;
>    469          bnxt_qplib_ring_nq_db(&nq->nq_db.dbinfo, nq->res->cctx, true);
>    470
>    471          return rc;
>
> I think that maybe the intent was to "return 0;" here even if setting
> the hint failed.
Yes, you are right, this should had been return 0 instead.
>
>    472  }
>
> regards,
> dan carpenter

--000000000000bcbeda05b45b2e06
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
tnoUdLZfhA/Um5MmzHQ2FwVWrEdFnwnb4r8hmwRuXwHqNC/ObUvqEvhIhIP8cC0fp6rb4JOvE40C
AwEAAaOCAdEwggHNMA4GA1UdDwEB/wQEAwIFoDCBngYIKwYBBQUHAQEEgZEwgY4wTQYIKwYBBQUH
MAKGQWh0dHA6Ly9zZWN1cmUuZ2xvYmFsc2lnbi5jb20vY2FjZXJ0L2dzcGVyc29uYWxzaWduMnNo
YTJnM29jc3AuY3J0MD0GCCsGAQUFBzABhjFodHRwOi8vb2NzcDIuZ2xvYmFsc2lnbi5jb20vZ3Nw
ZXJzb25hbHNpZ24yc2hhMmczME0GA1UdIARGMEQwQgYKKwYBBAGgMgEoCjA0MDIGCCsGAQUFBwIB
FiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzAJBgNVHRMEAjAAMEQGA1Ud
HwQ9MDswOaA3oDWGM2h0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20vZ3NwZXJzb25hbHNpZ24yc2hh
MmczLmNybDAlBgNVHREEHjAcgRpkZXZlc2guc2hhcm1hQGJyb2FkY29tLmNvbTATBgNVHSUEDDAK
BggrBgEFBQcDBDAfBgNVHSMEGDAWgBRpcoJiMWeVRIV3kYDEBDZJnXsLYTAdBgNVHQ4EFgQUejri
YFVTUGQI5jnygERBLGJqthQwDQYJKoZIhvcNAQELBQADggEBAK59nBqrRe7tf1qiVTnSELey+GjO
RzDtIHNl66UXog5du+L7BAXhpVOnNGdNRQWtvxhJA3LYMw7WjEgQSgelI3PhxgCmGhQXZWGIjJZQ
3HReWxVhGcTu0j7VZ562Xu2ETFi4MjT4PtXGVj70czPJlJR3pNnPwGNoFbYFXhvi5yaIvMTspNDm
Q7qDMBaBY8mWNb2JNxqUppF7suvUYx8EuYBc7cBOTsSlUvJRvm8mXMjMgZ4t6ARZMlgFtD3yznfK
Fg5OvZeAfG0lXvU4iZnc0fMvUDdUgIj0V/6FL5m8KunLIGLtZzA4BeAkKphvyJS1xZ/pzSNoDl+y
KV5Fs4Z9ha0xggJvMIICawIBATBtMF0xCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWdu
IG52LXNhMTMwMQYDVQQDEypHbG9iYWxTaWduIFBlcnNvbmFsU2lnbiAyIENBIC0gU0hBMjU2IC0g
RzMCDGD1/mnZg1yBtZ/T4zANBglghkgBZQMEAgEFAKCB1DAvBgkqhkiG9w0BCQQxIgQgExNMYshF
VcolkK6E7QC59JSC1o8QjgVBp99ugriiG1QwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkq
hkiG9w0BCQUxDxcNMjAxMTE4MDU1MDAyWjBpBgkqhkiG9w0BCQ8xXDBaMAsGCWCGSAFlAwQBKjAL
BglghkgBZQMEARYwCwYJYIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBCjALBgkqhkiG
9w0BAQcwCwYJYIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBADaxWUlRe7IAd/bw2+V+yUZ9CTKX
PkV5npe0AsLI8o6aC7sU5Qy71ge82r228LZ3t8tNrtQ+HpS7UL0XZnnK8fUz6xB4x7rAfG4lMY1j
oqwUTu3GfqK3hQ0j6w66TrqAvhyPdjwMvC+CsePX+VqZ/aHOKPw49cTIqUbVH7kdk7uBoWzynf0L
hiwAeJGaXPWaK/BmpghwECWQ7tv1aW2Zs9H0N+CjUsQeIyOekxOpfiuAv8iBQorrIgLCOV90ik2M
QFUdnmtKRzqDPHdI5FmaMmdhvVqqmwSBnOorbojDGZC8AZvKJIjcQdmqjCO7Zt6hlIt2sZEnyZJe
iLKti59gMYQ=
--000000000000bcbeda05b45b2e06--

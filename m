Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 990AC12D048
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Dec 2019 14:30:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727445AbfL3Nam (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 30 Dec 2019 08:30:42 -0500
Received: from mout.web.de ([212.227.15.14]:48705 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727397AbfL3Nam (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 30 Dec 2019 08:30:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1577712616;
        bh=sZdtUvNTDwfpY8AitIo7Yb6SiaGz0Pnr81mwDfMRMbQ=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=egJE/xK/2oSNJKqFJ2I/GkD/Itie1O4ZymgT2CMl8jlVbxgdqvEXiLH+fn5Lw+jBX
         jdVbqMWV4I0xhZSpeqb/za7zS1bq7PWcLvVg1Z4xZw/qaSGtl8npPk/2CRejf3DeGS
         zgB0NreshSFbhbfKVvGd1ByIKUQx51EbiVClJbNg=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.244.81.76]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LmQS2-1jLWn40OLC-00a0Fz; Mon, 30
 Dec 2019 14:30:16 +0100
Subject: Re: [PATCH v4] infiniband: i40iw: fix a potential NULL pointer
 dereference
To:     Xiyu Yang <xiyuyang19@fudan.edu.cn>
Cc:     Yuan Zhang <yuanxzhang@fudan.edu.cn>, Kangjie Lu <kjlu@umn.edu>,
        Leon Romanovsky <leon@kernel.org>,
        Xin Tan <tanxin.ctf@gmail.com>,
        Faisal Latif <faisal.latif@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Shannon Nelson <shannon.nelson@intel.com>,
        Anjali Singhai Jain <anjali.singhai@intel.com>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1577672668-46499-1-git-send-email-xiyuyang19@fudan.edu.cn>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <b10552be-7b43-911e-a240-8a0ffb43d231@web.de>
Date:   Mon, 30 Dec 2019 14:30:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <1577672668-46499-1-git-send-email-xiyuyang19@fudan.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rwjF5NVATm3VREfciWlhkDZTQ1E7shEPsnIKmJvb7cIQxZVIm7A
 7GHgR4TUK+O0iuE0KWKxnpdiIIwYi74Qp2aMikpYNYNm5Km6GnYsO4PXb07fPaTWttQkaR5
 enqCfv+81RHxFVOS4XWyyoM5BBB037rOtosqjOlz8QfGY2nq7puiVmz3JIdnrykxriBB1k2
 juVriHHKBQBEA087vMhUg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:J26PKoR76JA=:vh819MzkTNCkiQKurwpINg
 l+bYPLA9kjp+Mu6KGItKvXWHWjqVzBhWMQhTH6B6ovmFzc04Nw50XGWFMn6hyx6gbnY3E/Jya
 j9V2/DzpERokv/zNJT6oc544FvSmpv09bP6e9rfEO8rhrh+iNADDI7MGqoF9Jnimyibp6VeNQ
 KH3JRPbVwjzOQPcYkk8GJh2Yamb+wqprNzf2loNHEIorUT9D2/i/+CSDbnGnTwNhaGuh1077+
 /FJLcgt2U5Mv+muB8Blms8wlw0uv30eFGXbpi6863QIR2GyjP48qdMIZgQKFkAERnexN4oJEz
 /NJb0Lrx1bvm7MAPSRqhUSaicOpdLkmQ4pWazI06oBxLPpJg8bpLa0OxcfM/qUmYpRBJQKH/E
 plywj5LQpxboqCvYbyTQ8AK/7S194BKH5qcmwfxqDuQYndmBY0DXnJ0W1ZUpA1ayer59fkw7l
 mYP3qj9KenGYzXMBdhPMvR/YRfIPDwEFVynBk1Xm/mcgR1dN3Lpu1NhkhBO27u3FKccncGSgg
 8kmFCRPNtkQIY0By3/YS38UuETlWz2uicd8ZWNywzFKkeWPrUCjkh2aGLtJuGVhLUeotBKnje
 elhyLlfzFxUIKg4LcOYZcrhmSaaS3HDtmp/A2rc1C2FXFqj8hNhVvaGGaKvVKTt3/QGV/kMVc
 lwwo5Ra2L2tmx5w6raG5KY+/YS5GX8d5RdxJP0wcsupTYCB6cCzxejfyE6XdxySoeirvZ51l0
 GvZ7CIfMi5O6zUgCXR+RItF9cHk7mWcqkAXwWx0t0Jls8BVxe1OSFCNoxz+kdHLkF8FNLna5U
 OMrjkD41xzDMrRvlTv1rRANirj2k150wS0ddbrr3J98+FPY6Dk3re74UJimAs8i8vkK6Nzjd0
 4+My2zr8y4AZx8nNlpASmctpTX+fRG2LLRV/MITNK1i1utA+0fZHXLOZ4NMOw/Mv1wTBJ9qW7
 kux48bdbukVfVYInHDEXGElwz/CRtYXeeIDcU+l8LCJT49emxr89lU0I3DeNHnCp3GSAsXsM/
 XndGeCNXSt/qdXIj49LbNfYo08z+iBIcL1qEWAqnYTBedQYx7O857th0njZp2QbtQEV2cEYif
 SWgOx9NF8M1+7e9cFwVKUAsBWCqa7HyEnMcBqX+oZIPIJFGNj0apAMmb2yVzrch7Ff+kMNV6P
 Aw7kjL8zo0H53E+QZwKJQUcLU1PEbFI7GdcLijObILqXCIpSF1bkXRfKFHEFd1rroEPCytrA+
 6eaSQzYhwG3jtyJtNDiylVoO70ThlAN4Uiq/bP/UEU6j8W3KnErveq+J6dLU=
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

I suggest to reconsider the distribution of mail addresses for subsequent =
patches.
I would find it more appropriate to put your address in the field =E2=80=
=9CCc=E2=80=9D
while others should probably be specified in the message field =E2=80=9CTo=
=E2=80=9D.

Regards,
Markus

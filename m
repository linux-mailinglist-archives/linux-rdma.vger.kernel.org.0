Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3569B4B99DD
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Feb 2022 08:34:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234954AbiBQHer (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 17 Feb 2022 02:34:47 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236332AbiBQHeq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 17 Feb 2022 02:34:46 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D9832A22B7
        for <linux-rdma@vger.kernel.org>; Wed, 16 Feb 2022 23:34:30 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id n19-20020a17090ade9300b001b9892a7bf9so8655411pjv.5
        for <linux-rdma@vger.kernel.org>; Wed, 16 Feb 2022 23:34:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=YLWP3D1pdQe1DBTpoKOtFNbkAooYi+qGWB+iMmW5MAw=;
        b=0Gvygsh+g/5jbrU4GfkqKZlKH03oGT1MXKlaBgY2lA27h8uhU0wFGG/En66QTBfz0X
         yHX5V21Rr6HK4iD1rUYd26FENKuwR6nQxjSNpKMWlUkAbkR0Ao/XLfVJrqKQCgKLnFk5
         HErzPeMlrWLFyU1gDDup3QvSFvN7DJcMQ9aKLt9uZ52vHMLcX8+M1MODQIuxnGVQETSa
         OFFbZovAuz/ZXvbr9WfWLpc4sAeT7GWOl8IybPm+vQwXorohRMDeUMWejldo5AGYstRq
         Gd2+aWnNJ/V4KbCrn40aohvz0xrsEPqu9ZPU84w/sC92YszVuAyFZgvIH4E4N34VNupT
         cvag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=YLWP3D1pdQe1DBTpoKOtFNbkAooYi+qGWB+iMmW5MAw=;
        b=BUU9lhUJGvK2kPhnijmNteeOzVvhvbjXJ7Rh9bxCUQWNHhL9UYArwkvHVNQOgOyHRI
         6aUDcOezujoPKhgwVWu+8s2VdDWmbuQK116kUMFtuFE0iuY6KJp+fFUh3xQMzPrtMYMr
         cB5NXsbmeOpMS5OON0tFKtuNbj2dYCPajocZ850HBZu53fYFB+IfsuJxdG7mtH7XpS+i
         3zq75RCc8IOvoEHoKAfXOmhR28IklzvcawCvU1QN28cGpuMy8RiEEi7tC2AiG5XHozGy
         89KOT3tWsHhb2onVrDWHaeTmvvseUin6DOaQTNZkjt9zBERJmEGsxAjbEpA9x4p77xDm
         jjOA==
X-Gm-Message-State: AOAM530skTEMPrJ9EtAnNYHWj008lzEGmP/7SjbIqHNYvcyCJl00P7kb
        Yv6ZFx5c3FZ0lp0Wftlnjn5Ptw==
X-Google-Smtp-Source: ABdhPJxwgL1RKVDVtYVXFTxe9eEHs49AYVROC4xxWXvLfPP/FNsd2kb7ypEUd23HGW1OsD+DFDVG7w==
X-Received: by 2002:a17:902:704b:b0:14d:2c86:387 with SMTP id h11-20020a170902704b00b0014d2c860387mr1746503plt.1.1645083269772;
        Wed, 16 Feb 2022 23:34:29 -0800 (PST)
Received: from smtpclient.apple ([139.177.225.225])
        by smtp.gmail.com with ESMTPSA id t11sm7849191pgi.90.2022.02.16.23.34.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Feb 2022 23:34:29 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.20.0.1.32\))
Subject: Re: [External] [virtio-dev] Re: [RFC] Virtio RDMA
From:   Junji Wei <weijunji@bytedance.com>
In-Reply-To: <CACGkMEvP1dJv81Jy9aQV3GyrAFiYqt_y8rhz2O15wP9SWMeing@mail.gmail.com>
Date:   Thu, 17 Feb 2022 15:34:22 +0800
Cc:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, mst <mst@redhat.com>,
        yuval.shaia.ml@gmail.com,
        Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Hannes Reinecke <hare@suse.de>,
        Virtio-Dev <virtio-dev@lists.oasis-open.org>,
        Yongji Xie <xieyongji@bytedance.com>,
        =?utf-8?B?5p+056iz?= <chaiwen.cc@bytedance.com>,
        Xiongchun Duan <duanxiongchun@bytedance.com>,
        zhoujielong@bytedance.com, zhangqianyu.sys@bytedance.com,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <93C619CD-C9A7-4013-A780-0F98A298A7CA@bytedance.com>
References: <20220215081353.10351-1-weijunji@bytedance.com>
 <CACGkMEv44vBkUD4YZHg-irzNfxsKjZ4kMZH91LkEYfmmWWhsBA@mail.gmail.com>
 <B07F1166-36A4-4B17-A063-F5447296B99D@bytedance.com>
 <CACGkMEsoKact5us2tHK226ui9fe7DTcMy0BPbE1Ohd0bTpxwWg@mail.gmail.com>
 <19CC8304-C2B3-45A7-BFDB-28E9D0D4A02A@bytedance.com>
 <CACGkMEsafzRWYxEw1YUYHka3sm3tH7qXYhcad++NYcfS6LXFLg@mail.gmail.com>
 <F801A40A-FB1B-41C6-B409-0106A66E6EDB@bytedance.com>
 <YgynQGK/xog1ugEd@unreal>
 <2818E401-AA08-42DB-90C0-75B199ECE47E@bytedance.com>
 <CACGkMEvP1dJv81Jy9aQV3GyrAFiYqt_y8rhz2O15wP9SWMeing@mail.gmail.com>
To:     Jason Wang <jasowang@redhat.com>
X-Mailer: Apple Mail (2.3693.20.0.1.32)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



> On Feb 17, 2022, at 3:02 PM, Jason Wang <jasowang@redhat.com> wrote:
>=20
> On Wed, Feb 16, 2022 at 4:01 PM Junji Wei <weijunji@bytedance.com> =
wrote:
>>=20
>>=20
>>> On Feb 16, 2022, at 3:26 PM, Leon Romanovsky <leon@kernel.org> =
wrote:
>>>=20
>>> On Wed, Feb 16, 2022 at 03:13:11PM +0800, Junji Wei wrote:
>>>>=20
>>>=20
>>> <...>
>>>=20
>>>>>> We can't. So do you mean we can implement virtio-rdma only for IB =
in the future?
>>>>>=20
>>>>> It's probably virtio-IB but we need to listen to others.
>>>>=20
>>>> Agreed, one problem is that there might be some duplicated works.
>>>=20
>>> Once it will be needed, the code can be refactored. IB and RoCE are
>>> different from user perspective, so combining them into one =
virtio-rdma
>>> module doesn't give too much advantage.
>>=20
>> Yes, code would be fine. But there maybe some duplicated contents in =
spec.
>=20
> We can carefully design the interfaces in order to eliminate the
> duplication in the spec.

Ok, we will try to extend virtio-net spec in v2.

Thanks.


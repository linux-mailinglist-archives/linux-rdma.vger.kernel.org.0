Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 138AF18AA78
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Mar 2020 02:54:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbgCSBy1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 18 Mar 2020 21:54:27 -0400
Received: from mail-pf1-f172.google.com ([209.85.210.172]:45440 "EHLO
        mail-pf1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726777AbgCSBy1 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 18 Mar 2020 21:54:27 -0400
Received: by mail-pf1-f172.google.com with SMTP id j10so482992pfi.12
        for <linux-rdma@vger.kernel.org>; Wed, 18 Mar 2020 18:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=EBuP8wFcDWQjE90QiUIty8tjggf7FtDsz4+pTxsW6U4=;
        b=WIy+BdDZLlk5lzfzrpaLdL1HATHXOuYvEhi/c7W5CwmBo/VUHEG8by0NIfH73vlKo0
         TD5dyCpItpCWiw9dC9jE57t8uBtMLElMJ3c18RFNDxxq9PACitMezUjGAPlecFa/qUU+
         eBGfh94lL6T9SgwBFA74UjiRUFSaUxl2ZUksIV4sV/7xGxuOShMdOzdwDib0T1F9ZSjX
         tsWopgoXZNyWU38MqU740YaYmVP0U6U0JwUhomqN7ojFSRG7H8LUt4OVRG8w4r5gbbsp
         /5A+4Y8fvbK0XEs6oOuAW1Jz3MceLKEe5lrtWXYDhitr8meT8u2zRq3RUX/Xvjr2Jp2Z
         jx5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=EBuP8wFcDWQjE90QiUIty8tjggf7FtDsz4+pTxsW6U4=;
        b=q0kLfGn88aVbyxBORTRL4COYyhMnZ2SYgnk/5HNpS95mDmwRKV6nVDXUDq9py2XAB2
         EIKXS3DkgF+CwyPFS2G4EhC9bWJhXuA+xrIapdBPcgxn2SxTuK+5wRwsim/+DVo2ZOLu
         TO122wvhxoPXfWobGyoZwlY+4r81fmhvUp52lXT+wk48G98ibfAa4gO29Q7QSLM3InrT
         bBJv1nPVAVzsu9jaQhJlwGIhUluC8/lMzizGdtMElMQlyt3sQzV3tVgDKBF8ZKIK9wdj
         Iq5CQIzE3WkigdtilDHMYAyNtAvOCa2jU9sfeDkPe213gIDsOwhHoQ6LUVU8qog5JXL0
         ZaXQ==
X-Gm-Message-State: ANhLgQ1CNS12mg3eUGv+vzpQDbtkxv4n0gkf6kaoQ0MC30J3o+GMFhFD
        vaIeM24tsxqtzhAJ/MW39FYU9aWc
X-Google-Smtp-Source: ADFU+vuPvidviiPgWohLl8gHvGR5tZ6Q2HeiGKIFcjj1ceoizYV0+04+73tntVugZc/V2fnX7evqcw==
X-Received: by 2002:a63:4cc:: with SMTP id 195mr732523pge.93.1584582865885;
        Wed, 18 Mar 2020 18:54:25 -0700 (PDT)
Received: from [10.75.201.14] ([118.201.220.138])
        by smtp.gmail.com with ESMTPSA id y30sm277344pff.67.2020.03.18.18.54.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Mar 2020 18:54:25 -0700 (PDT)
Subject: Re: RoCE v2 packet size
To:     Dimitris Dimitropoulos <d.dimitropoulos@imatrex.com>,
        linux-rdma@vger.kernel.org
References: <CAOc41xF2xRfSpZDn-XRA=R+SegMJTPU6GJe6_6q=0j4=a-Bw9w@mail.gmail.com>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Message-ID: <900a17aa-cadd-46a5-9f15-246d5f65cd1d@gmail.com>
Date:   Thu, 19 Mar 2020 09:54:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CAOc41xF2xRfSpZDn-XRA=R+SegMJTPU6GJe6_6q=0j4=a-Bw9w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Please refer to SoftRoCE.

On 3/19/2020 6:57 AM, Dimitris Dimitropoulos wrote:
> Hi,
>
> In RoCE v2 there various options for the protocol packet size: 4096,
> 2048, etc. To what does this number refer to exactly. Is it the
> payload that ends up in the QP buffers, or does it include headers
> some of the headers as well ?
>
> Thank you.
>
> Dimitris


